# wyrd_server

WYRD's backend: a **Serverpod 4** (Dart) server on Serverpod Cloud (project `wryd00`). It runs
WYRD's mind and background life, Dialogue Link, the task agent, the Academy, games, the drone
planner, the NAIJA 2099 city, and the partner API. The app is in the `consciousness-bot`
repository (`mobile/`); the generated Dart client is `../wyrd_client`.

- API (RPC): `https://wryd00.api.serverpod.space`
- Web host: `https://wryd00.serverpod.space` — the app's web build (`web/app/`) and custom routes:
  the partner API (`/partner/v1/**`) and the Konnectly demo page (`/konnectly`)

## Where things are

```
lib/src/
  mind/       WYRD's mind: chat (ChatService, ChatToolService, chats in ChatList), memory and
              recall, lexicon, diary, dreams, reasoning, feeds and trust; the model and its
              budget (claude.dart, llm_budget.dart); test questions (EvalService) and the
              owner's dashboard (DashboardEndpoint); web search, news and prices
              (web_search_service.dart); training data
  agent/      the task agent: plans, uses tools, reports; acting waits for the owner's yes
  world/      NAIJA 2099: the city and its authority, the naira ledger (bank.dart -- all money
              moves through Bank.post), wallet, jobs, homes, story missions, Fair Streets police,
              city signals and the live wire
  partner/    the partner API (/partner/v1) and its owner controls (partnerAdmin)
  konnectly/  the open Konnectly demo (no sign-in, its own daily allowance)
  drone/      flight planning and safety checks; the operator (owner) accounts
  games/      chess, Connect Four, Reversi, tic-tac-toe, ratings
  generated/  Serverpod's generated code -- never edit by hand
```

Models are `*.spy.yaml` files next to the code that uses them.

## The model and its budget

WYRD runs on Claude Haiku 5.5 (`lib/src/mind/claude.dart`; vision uses a stronger model). Every
call goes through `LlmBudget`: a daily cap (`llmDailyBudgetUsd`), a share per person
(`llmUserDailyUsd`), and background thinking paced across the day. Spend is recorded from each
response's real token usage, with cache reads and writes priced as such.

## Secrets

Secrets are Serverpod passwords, never in the code or the repository: locally in
`config/passwords.yaml` (git-ignored), on the cloud with `scloud password set <name> <value>`
(e.g. `anthropicApiKey`).

## Working on it

```bash
serverpod generate          # after changing a .spy.yaml or an endpoint
serverpod create-migration  # after changing a model's table
dart analyze
dart test                   # unit + integration tests
```

(On Windows from Git Bash: `cmd //c "serverpod.bat generate"`, and likewise for the others.)

Integration tests (`test/integration/`) run against an embedded Postgres — no Docker needed — and
each test's database changes are rolled back. The first run after a while can fail in setUpAll
while Postgres starts; run it again. Tests make no real model calls (the partner tests stub the
model); the live model is checked from the owner's pages on the deployed app (`#dashboard` →
Run now, `#partners` → Test the API).

To run the server locally: `dart bin/main.dart --apply-migrations`, with a Postgres as set in
`config/development.yaml` (Redis is off).

## Deploying

From this directory, after the app's web build has been copied into `web/app/` (see the
consciousness-bot README):

```bash
scloud deploy
```

The cloud builds the server and rolls it out, applying new migrations; it takes a few minutes.
