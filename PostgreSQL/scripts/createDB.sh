#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER paradox_user WITH PASSWORD '1234';
    CREATE DATABASE db_paradox OWNER paradox_user;
EOSQL