# Funded split-paycheck: repository assessment and plan

Status: **assessment only. Nothing implemented, migrated or enabled yet.**
Scope: `wyrd_server` (Serverpod 4, PostgreSQL) and the Lagos Island client (`lagos-island/web/index.html`).

## 1. What exists today

### Money: one currency, Game Naira only

| Piece | Where | What it does |
|---|---|---|
| Balance | `world_citizen.naira` (`int`, whole naira, default 5,000) | The player's Game Naira. A cached balance, changed only by `Bank`. |
| Payment plan | `world_citizen.debt` / `debtSince` | Owed Game Naira, capped at 10,000. A fifth of each payout repays it. |
| Ledger | `naira_entry` (`NairaEntry`) | One row per movement: `key` (unique), `amount`, `balanceAfter`, `kind`, `counter`, `memo`, `status` (`posted`/`reversed`), `reverses`. |
| Posting | `lib/src/world/bank.dart` → `Bank.post / owe / reverse` | One DB transaction per movement: `SELECT … FOR UPDATE` on the citizen row, idempotency by `key`, no overdraft, opening entry on first use, reversal by a linked opposite entry. |
| Audit | `Bank.audit` | Finds players whose entry sum ≠ cached balance. |
| Disputes | `naira_dispute` | Goodwill auto-refund up to ₦1,000/week; the rest queued for the owner. |
| Per-user serialisation | `IslandMeEndpoint._money` | An in-memory per-user promise queue (single server instance only). |

Strengths to reuse: unique idempotency keys, row locking, append-only entries with compensating reversals, and an opening-balance entry so history reconciles.

Gaps against the brief:
1. **Single-entry, not double-entry.** `counter` is only a label (`city:treasury`, `city:market` …). There are no counter-account balances, so the "Virtual City Treasury" has no balance, budget or audit today. Game Naira paid out by jobs is effectively **issued**, not drawn from a treasury.
2. **No unit/currency column.** Everything is assumed to be whole Game Naira (scale 0). There is no kobo or minor-unit concept.
3. **`Bank.reverse` mutates `status`** on the original row (`posted` → `reversed`). That is the one non-append-only write.
4. **`_money` is in-process.** Fine for one Serverpod instance; it does not protect against two instances. The DB row lock in `Bank.post` is the real guarantee.

### Jobs: no job has a contract or a reward snapshot

| Kind | Where | Server evidence | Pays |
|---|---|---|---|
| Island shifts (`work`) | `IslandMeEndpoint.work` | None beyond a time bucket and a daily cap | Game Naira, key `island:shift:{user}:{place}:{bucket}` |
| Timed jobs (delivery, danfo, chase) | `world/job_service.dart` | Server-timed, distance plausibility; **open jobs kept in memory** (`_open`), lost on restart | Game Naira |
| Missions / story / guide | `world_authority.dart`, `story_service.dart` | Server-issued | Game Naira |
| Employer listings | `island_job` / `island_application` | Operator review | **No pay in-game**; real-world jobs only |

None of these has an offer, an acceptance, a deadline, or a stored reward that is fixed at acceptance.

### Real money: none

- No currency purchases, payment provider, payout, withdrawal, KYC, webhook or kobo amounts in the game.
- `partner_api.dart` reads bank-transfer receipts (`amount_kobo`) for the Konnectly partner. It is unrelated, and should not be reused for payouts.

### Roles and admin

- One role: `DroneService.isOperator`. No role-based permissions, no dual approval and no admin audit log.

### Levy

- None exists. "City levy" appears only as story text. There are **no player-to-player Game Naira payments**, so an allowlisted commercial levy has nothing to apply to yet.

## 2. Ambiguities and decisions needed

| # | Question | Why it matters | Proposed default |
|---|---|---|---|
| D1 | Game Naira precision | The brief wants explicit scale; today it is whole naira | Keep scale 0 (whole G₦), documented; no migration of existing balances |
| D2 | Where funded-job Game Naira comes from | Brief: from the City Treasury with a budget, or an explicit issuance event | Explicit **issuance event** per completion (today's behaviour, now recorded), with a treasury model added later |
| D3 | Which jobs become funded | No current job has acceptance or a server-verifiable completion fit for real money | A new job type built on `JobService` with persisted acceptances, not shifts |
| D4 | Verification hold length | Brief says "published verification process", with no value given | Config value; **no default for live**; sandbox uses 0 |
| D5 | Payout-cost allowance per reward | Test 3 assumes ₦835 per reward on ₦50,000 → 33 accepted | Configurable allowance in kobo; reserved with the reward unless separately budgeted |
| D6 | Who funds the Real Rewards Fund | No purchases exist, so the 50% allocation has no source | Manual, dual-approved funding records backed by reconciled bank evidence |
| D7 | Age, jurisdiction, KYC provider and limits | Required before live payouts | **Blocked** until supplied; no invented values |
| D8 | Player-to-player payments | Needed before a levy means anything | Out of scope until such payments exist; levy built behind a flag with tests only |

## 3. Migration risks

- **New tables only.** Phase 1 adds tables; it does not alter `world_citizen` or `naira_entry`, so existing balances and history are untouched.
- **No change to existing Game Naira rights.** Funded-job Game Naira is posted through `Bank.post` with new `kind`s, so the current audit still holds.
- **Multi-instance safety.** All new money paths use database locks and constraints, not the in-memory queue.
- **Rollback.** Tables are additive; disabling the feature flags stops all new activity without deleting liabilities.

## 4. Security gaps to close as part of this work

1. Persist job acceptances (today a restart drops open jobs, so completions can't be replayed or audited).
2. Server-side evidence for funded completions; replay protection with a unique entitlement per acceptance.
3. Role-based permissions (`treasury_viewer`, `treasury_operator`, `treasury_approver`) and **dual approval** for funding records and manual real-money adjustments.
4. An admin audit log (append-only).
5. Provider abstraction with signed-callback verification, idempotent submission, and "unknown" as a first-class payout state.
6. Secrets server-side only; real-money fields redacted in logs.

## 5. Proposed design

### Units and ledgers

- **Game Naira**: unchanged `NairaEntry` / `world_citizen.naira`, scale 0.
- **Real NGN**: a new, separate double-entry ledger in **kobo** (`bigint`):
  - `ngn_account`: system accounts (`fund:uncommitted`, `fund:reserved`, `fund:fee_reserved`, `earnings:pending`, `earnings:available`, `payout:in_flight`, `payout:paid`, `provider:fees`, `external:bank`) and per-player liability accounts.
  - `ngn_journal`: one business transaction (unique `ref`, `idempotencyKey`, `kind`, links).
  - `ngn_entry`: append-only debit/credit lines; every journal sums to zero, enforced by the posting code plus a deferred check.
  - Balances are derived from entries; any cache is updated in the same transaction and reconciled.
- NGN never balances against Game Naira. A funded completion writes one Game Naira entry and one NGN journal, linked by the same reference.

### Policy and jobs

- `reward_policy` (versioned, immutable once used): `cashShareBp = 167` (1.67%), unit conversion 1 basis unit = ₦1, rounding rule, fee allowance in kobo.
- Split for basis 30,000: cash = round_half_up(30,000 × 1.67%) = ₦500 (exact: ₦501 → **the brief's ₦500 implies a rule**; see D9 below), game = 30,000 − 500 = G₦29,500.
- `funded_campaign`: budget source, status (active / paused-new-jobs), counters derived from the ledger.
- `job_offer`: type (`ORDINARY_GAME_JOB` | `FUNDED_SPLIT_JOB`), immutable reward snapshot (game G₦, cash kobo, fee allowance kobo, policy version), validity window.
- `job_acceptance`: unique (offer, player) plus an idempotency key; status; deadlines; the reservation journal ref.
- `job_completion`: unique per acceptance; evidence; review state; appeal state.
- `withdrawal_request`, `provider_event` (unique provider event id), `funding_allocation`, `reconciliation_run`, `admin_audit_event`.

**D9 (new): rounding to reach ₦500.** 30,000 × 1.67% = ₦501, not ₦500. ₦500 is exactly 1/60 (1.666…%). I propose storing the share as the fraction **1/60** and rounding cash **down to the whole naira**, which gives ₦500 / G₦29,500 for basis 30,000 and never over-promises cash. Please confirm.

### Flows

- **Accept (funded)**: authenticate → flags and limits → lock the campaign row (`FOR UPDATE`) → check uncommitted ≥ cash + fee allowance → journal: `fund:uncommitted` → `fund:reserved` / `fund:fee_reserved` → insert acceptance (unique idempotency key) → return the snapshot.
- **Complete**: verify server evidence → unique entitlement insert → Game Naira `Bank.post` (key `funded:{acceptanceId}`) → journal `fund:reserved` → `earnings:pending:{player}` → fee allowance stays reserved for the payout.
- **Release after hold**: scheduled job moves eligible `pending` → `available`; never while under review or appeal.
- **Expiry / cancel**: release the reservation back to uncommitted only when no completion or appeal is open.
- **Withdraw**: available → `payout:in_flight` with a unique payout ref → provider submit (idempotent) → callback / poll: confirmed (→ paid, fee to `provider:fees`), failed/returned (→ back to available, once), unknown (stays in flight until reconciled).

### Flags (default off)

`FUNDED_JOBS_ENABLED=false`, `LIVE_COLLECTIONS_ENABLED=false`, `LIVE_PAYOUTS_ENABLED=false`, `CITY_LEVY_ENABLED=false`. Live payouts additionally require every item in D7 to be configured, or activation fails.

## 6. Phases and acceptance criteria

| Phase | Delivers | Done when |
|---|---|---|
| 1. Ledger core | NGN accounts, journals, entries, posting service, policy, split calculator, roles, admin audit | Tests 1, 13, 14 pass; journals always balance; no change to existing balances |
| 2. Funded jobs | Campaigns, offers, acceptance with reservations, completion, hold release, expiry and cancellation | Tests 2, 3, 4, 5, 6, 15 pass under concurrency |
| 3. Withdrawals (sandbox) | Provider abstraction, mock adapter, withdrawal state machine, signed callbacks, reconciliation | Tests 7–12 pass; unknown outcomes stay reserved |
| 4. Player UI | Separate Game Wallet and Real Earnings; reward preview; funding indicator; history; withdrawal status; dispute ref | Copy matches the hold and fee terms; pending is never shown as paid |
| 5. Admin tools | Fund dashboard, pause switches, flagged completions, reconciliation diffs, CSV export | Every figure is derived from the ledger; no double counting across states |
| 6. Optional | 50% purchase allocation, city levy | Built behind flags with tests; not enabled |

Test 16 (existing balance migration) is satisfied by design: no existing balance or entry is migrated or changed.

## 7. Launch blockers (cannot be resolved in code)

Legal classification and customer terms; a payment provider that supports this exact model; KYC and beneficiary verification; age and jurisdiction rules; limits, minimum withdrawal and fees; the verification hold period; accounting rules for funding allocation; dispute and support procedures; reconciliation against real bank statements.

## 8. Decisions (owner, 2026-10-19)

- **D9 cash split:** 167 basis points (1.67%), cash rounded **down** to the whole naira, game = basis − cash. Basis 30,000 → **₦501 cash + G₦29,499 game**. This differs from the brief's example (₦500 / G₦29,500), so test 1 is written against this rule.
- **D2 game source:** two separate treasuries, both visible **to admins only** inside the game:
  - the **Virtual City Treasury** (in the game) holds Game Naira and pays the game half of funded paychecks, so Game Naira needs a real treasury balance (double-entry for the treasury side);
  - the **Real Rewards Fund** (outside the game) records deposited money and pays the cash half.
- **D3:** a new funded job type with persisted offers, acceptances, deadlines and server-checked completion. Shifts and missions stay game-only.
- **Order:** finish the 3D outfits first, then build this system (sandbox only, every flag off).
