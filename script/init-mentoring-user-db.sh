#!/usr/bin/env bash
set -e

if [ "$DB_USERNAME" == "postgres" ]
then
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
        CREATE DATABASE "$DB_NAME";
    EOSQL
else
    # @see: https://docs.docker.com/samples/library/postgres/#arbitrary---user-notes
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    	CREATE USER "$DB_USERNAME";
    	ALTER USER "$DB_USERNAME" WITH ENCRYPTED PASSWORD '$DB_USERPASS';
    	CREATE DATABASE "$DB_NAME";
    	GRANT ALL PRIVILEGES ON DATABASE "$DB_USERNAME" TO "$DB_NAME";
    EOSQL
fi
