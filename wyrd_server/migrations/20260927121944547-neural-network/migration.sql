BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "synapse" (
    "id" bigserial PRIMARY KEY,
    "a" text NOT NULL,
    "b" text NOT NULL,
    "weight" double precision NOT NULL,
    "fires" bigint NOT NULL,
    "lastFired" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "synapse_pair_idx" ON "synapse" USING btree ("a", "b");
CREATE INDEX "synapse_weight_idx" ON "synapse" USING btree ("weight");


--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260927121944547-neural-network', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260927121944547-neural-network', "timestamp" = now();

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



--
-- DATA: dreams are public, and older ones could be built from private chats or photos. Remove those.
--
DELETE FROM "dream_entry" d WHERE EXISTS (
    SELECT 1 FROM json_array_elements_text(d."sourceBlockIds") AS x(id)
    JOIN "memory_block" m ON m."id" = x.id::bigint
    WHERE m."source" IN ('chat', 'photo')
);

COMMIT;
