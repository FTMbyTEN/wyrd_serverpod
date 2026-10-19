BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "funded_campaign" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "status" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_acceptance" (
    "id" bigserial PRIMARY KEY,
    "offerId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "idemKey" text NOT NULL,
    "status" text NOT NULL,
    "taskSpec" text NOT NULL,
    "gameReward" bigint NOT NULL,
    "cashKobo" bigint NOT NULL,
    "feeKobo" bigint NOT NULL,
    "holdHours" bigint NOT NULL,
    "acceptedAt" timestamp without time zone NOT NULL,
    "deadline" timestamp without time zone NOT NULL,
    "reserveRef" text,
    "completedAt" timestamp without time zone,
    "note" text
);

-- Indexes
CREATE UNIQUE INDEX "job_acceptance_idem_idx" ON "job_acceptance" USING btree ("idemKey");
CREATE UNIQUE INDEX "job_acceptance_once_idx" ON "job_acceptance" USING btree ("offerId", "authUserId");
CREATE INDEX "job_acceptance_user_idx" ON "job_acceptance" USING btree ("authUserId", "acceptedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "job_offer" (
    "id" bigserial PRIMARY KEY,
    "type" text NOT NULL,
    "campaignId" bigint,
    "title" text NOT NULL,
    "task" text NOT NULL,
    "basis" bigint NOT NULL,
    "gameReward" bigint NOT NULL,
    "cashKobo" bigint NOT NULL,
    "feeKobo" bigint NOT NULL,
    "policyVersion" bigint,
    "places" bigint,
    "closesAt" timestamp without time zone NOT NULL,
    "completeMinutes" bigint NOT NULL,
    "status" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_account" (
    "id" bigserial PRIMARY KEY,
    "code" text NOT NULL,
    "unit" text NOT NULL,
    "kind" text NOT NULL,
    "ownerUserId" uuid,
    "balance" bigint NOT NULL DEFAULT 0,
    "mayGoNegative" boolean NOT NULL DEFAULT false,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_account_code_idx" ON "reward_account" USING btree ("code");
CREATE INDEX "reward_account_owner_idx" ON "reward_account" USING btree ("ownerUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_audit" (
    "id" bigserial PRIMARY KEY,
    "actor" uuid,
    "action" text NOT NULL,
    "details" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "reward_audit_created_idx" ON "reward_audit" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_earning" (
    "id" bigserial PRIMARY KEY,
    "acceptanceId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "cashKobo" bigint NOT NULL,
    "status" text NOT NULL,
    "availableAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_earning_acceptance_idx" ON "reward_earning" USING btree ("acceptanceId");
CREATE INDEX "reward_earning_user_idx" ON "reward_earning" USING btree ("authUserId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_entry" (
    "id" bigserial PRIMARY KEY,
    "journalId" bigint NOT NULL,
    "accountId" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "reward_entry_journal_idx" ON "reward_entry" USING btree ("journalId");
CREATE INDEX "reward_entry_account_idx" ON "reward_entry" USING btree ("accountId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_funding" (
    "id" bigserial PRIMARY KEY,
    "unit" text NOT NULL,
    "amount" bigint NOT NULL,
    "evidence" text NOT NULL,
    "status" text NOT NULL,
    "proposedBy" uuid NOT NULL,
    "approvedBy" uuid,
    "journalRef" text,
    "createdAt" timestamp without time zone NOT NULL,
    "decidedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_journal" (
    "id" bigserial PRIMARY KEY,
    "ref" text NOT NULL,
    "idemKey" text NOT NULL,
    "unit" text NOT NULL,
    "kind" text NOT NULL,
    "memo" text NOT NULL,
    "linkRef" text,
    "actor" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_journal_ref_idx" ON "reward_journal" USING btree ("ref");
CREATE UNIQUE INDEX "reward_journal_idem_idx" ON "reward_journal" USING btree ("idemKey");
CREATE INDEX "reward_journal_link_idx" ON "reward_journal" USING btree ("linkRef");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_policy" (
    "id" bigserial PRIMARY KEY,
    "version" bigint NOT NULL,
    "cashShareBp" bigint NOT NULL,
    "feeAllowanceKobo" bigint NOT NULL,
    "holdHours" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_policy_version_idx" ON "reward_policy" USING btree ("version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_provider_event" (
    "id" bigserial PRIMARY KEY,
    "provider" text NOT NULL,
    "eventId" text NOT NULL,
    "payoutRef" text NOT NULL,
    "status" text NOT NULL,
    "signatureOk" boolean NOT NULL,
    "outcome" text NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_provider_event_idx" ON "reward_provider_event" USING btree ("provider", "eventId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_role" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL,
    "grantedBy" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_role_idx" ON "reward_role" USING btree ("authUserId", "role");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_switch" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "enabled" boolean NOT NULL,
    "updatedBy" uuid,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_switch_key_idx" ON "reward_switch" USING btree ("key");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reward_withdrawal" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "amountKobo" bigint NOT NULL,
    "feeKobo" bigint NOT NULL,
    "feePayer" text NOT NULL,
    "ref" text NOT NULL,
    "idemKey" text NOT NULL,
    "status" text NOT NULL,
    "provider" text NOT NULL,
    "providerRef" text,
    "beneficiary" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reward_withdrawal_ref_idx" ON "reward_withdrawal" USING btree ("ref");
CREATE UNIQUE INDEX "reward_withdrawal_idem_idx" ON "reward_withdrawal" USING btree ("idemKey");
CREATE INDEX "reward_withdrawal_user_idx" ON "reward_withdrawal" USING btree ("authUserId", "createdAt");


--
-- The rewards ledger is append-only: journals and entries can never be edited or deleted
--
CREATE OR REPLACE FUNCTION reward_append_only() RETURNS trigger AS $$ BEGIN RAISE EXCEPTION 'rewards ledger is append-only'; END; $$ LANGUAGE plpgsql;
CREATE TRIGGER reward_journal_append_only BEFORE UPDATE OR DELETE ON "reward_journal" FOR EACH ROW EXECUTE FUNCTION reward_append_only();
CREATE TRIGGER reward_entry_append_only BEFORE UPDATE OR DELETE ON "reward_entry" FOR EACH ROW EXECUTE FUNCTION reward_append_only();

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261019190208839', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261019190208839', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
