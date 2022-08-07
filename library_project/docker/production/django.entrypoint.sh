#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

export DATABASE_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

python << END
import sys
import time
import psycopg2
suggest_unrecoverable_after = 30
start = time.time()
while True:
    try:
        psycopg2.connect(
            dbname="${DB_NAME}",
            user="${DB_USER}",
            password="${DB_PASSWORD}",
            host="${DB_HOST}",
            port="${DB_PORT}",
        )
        break
    except psycopg2.OperationalError as error:
        sys.stderr.write("Waiting for PostgreSQL to become available...\n")
        if time.time() - start > suggest_unrecoverable_after:
            sys.stderr.write("  This is taking longer than expected. The following exception may be indicative of an unrecoverable error: '{}'\n".format(error))
    time.sleep(1)
END

>&2 echo 'PostgreSQL is available'

exec "$@"
