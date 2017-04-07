-- Revert balance-sheet:create_app_schema from pg

BEGIN;

DROP SCHEMA bs CASCADE;

SET search_path = public;

COMMIT;
