#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER userGestor WITH PASSWORD '1234';
    CREATE DATABASE db_Fiplan OWNER userGestor;
EOSQL