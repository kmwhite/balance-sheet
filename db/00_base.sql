-- Drop existing objects
DROP OWNED BY balance_sheet CASCADE;
DROP DATABASE balance_sheet_dev;
DROP ROLE IF EXISTS balance_sheet;

-- Create New Owners
CREATE ROLE balance_sheet WITH NOINHERIT LOGIN PASSWORD 'password';
CREATE DATABASE balance_sheet_dev WITH OWNER balance_sheet ENCODING UTF8;

-- Core Configurations
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;
SET default_tablespace = '';
SET default_with_oids = false;
