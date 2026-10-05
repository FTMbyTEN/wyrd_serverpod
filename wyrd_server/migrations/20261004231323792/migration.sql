BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "agent_step" (
    "id" bigserial PRIMARY KEY,
    "taskId" bigint NOT NULL,
    "run" bigint NOT NULL,
    "at" timestamp without time zone NOT NULL,
    "kind" text NOT NULL,
    "tool" text,
    "detail" text NOT NULL,
    "output" text
);

-- Indexes
CREATE INDEX "agent_step_task_idx" ON "agent_step" USING btree ("taskId", "at");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "agent_task" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "goal" text NOT NULL,
    "everyHours" bigint,
    "status" text NOT NULL,
    "result" text,
    "previousResult" text,
    "notes" text,
    "transcript" text,
    "pendingAction" text,
    "stepsUsed" bigint NOT NULL,
    "maxSteps" bigint NOT NULL,
    "runs" bigint NOT NULL,
    "unread" boolean NOT NULL,
    "nextRunAt" timestamp without time zone NOT NULL,
    "lastRunAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "agent_task_user_idx" ON "agent_task" USING btree ("authUserId", "status");
CREATE INDEX "agent_task_due_idx" ON "agent_task" USING btree ("status", "nextRunAt");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20261004231323792', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004231323792', "timestamp" = now();

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
