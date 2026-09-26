BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "drone_mission" (
    "id" bigserial PRIMARY KEY,
    "droneId" text NOT NULL,
    "kind" text NOT NULL,
    "instruction" text NOT NULL,
    "summary" text NOT NULL,
    "stepsJson" text NOT NULL,
    "status" text NOT NULL,
    "reason" text,
    "createdBy" uuid,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "drone_mission_drone_status_idx" ON "drone_mission" USING btree ("droneId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "drone_state" (
    "id" bigserial PRIMARY KEY,
    "droneId" text NOT NULL,
    "connected" boolean NOT NULL,
    "armed" boolean NOT NULL,
    "mode" text,
    "lat" double precision,
    "lon" double precision,
    "relativeAltM" double precision,
    "headingDeg" double precision,
    "groundSpeedMs" double precision,
    "batteryPct" bigint,
    "gpsFix" bigint,
    "satellites" bigint,
    "homeLat" double precision,
    "homeLon" double precision,
    "missionStatus" text,
    "missionStep" bigint,
    "missionError" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "drone_state_drone_id_idx" ON "drone_state" USING btree ("droneId");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260926133034722', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926133034722', "timestamp" = now();

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
