#!/usr/bin/env bash

# allow access from mentoring host to mentoring user
sed -i "87i host    $DB_NAME       $DB_USERNAME       mentoring            password" $PGDATA/pg_hba.conf
