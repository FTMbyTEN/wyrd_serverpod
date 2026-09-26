BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_profile" ADD COLUMN "email" text;

--
-- DATA MIGRATION (hand-written): every registered person gets a WYRD profile row with their email.
-- Profiles used to be created only when the app first opened the YOU tab, so many accounts had
-- none. Schema is unchanged by this block.
--
UPDATE "user_profile" AS p SET "email" = ea."email"
FROM "serverpod_auth_idp_email_account" AS ea
WHERE ea."authUserId" = p."authUserId";

INSERT INTO "user_profile" ("authUserId", "username", "email", "facts", "visitCount", "firstSeen", "lastSeen")
SELECT ea."authUserId", NULL, ea."email", '[]'::json, 0, ea."createdAt", ea."createdAt"
FROM "serverpod_auth_idp_email_account" AS ea
WHERE NOT EXISTS (SELECT 1 FROM "user_profile" p WHERE p."authUserId" = ea."authUserId");

--
-- MIGRATION VERSION FOR wyrd
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wyrd', '20260926153900710', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926153900710', "timestamp" = now();

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
