-- Deploy balance-sheet:create_app_schema to pg

BEGIN;

SET SESSION AUTHORIZATION balance_sheet;

-- Create New Owners
CREATE SCHEMA IF NOT EXISTS bs AUTHORIZATION balance_sheet;
SET search_path = bs, public;

RESET SESSION AUTHORIZATION;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: bs; Owner: balance_sheet
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA bs;
ALTER EXTENSION "uuid-ossp" WITH OWNER balance_sheet;
COMMENT ON EXTENSION "uuid-ossp" IS 'UUID Generation Framework';

COMMIT;
