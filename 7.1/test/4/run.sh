#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

docker-compose up -d
docker-compose exec mariadb make max_try=12 wait_seconds=5 check-ready -f /usr/local/bin/actions.mk
docker-compose exec nginx make max_try=10 wait_seconds=1 check-ready -f /usr/local/bin/actions.mk
docker-compose exec --user=82 php tests.sh
docker-compose down
