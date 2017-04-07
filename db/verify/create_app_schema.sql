-- Verify balance-sheet:create_app_schema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('bs', 'usage');

SELECT 1/COUNT(*) FROM pg_extension WHERE extname = 'uuid-ossp';

ROLLBACK;
