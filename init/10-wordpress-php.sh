#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

exec_tpl() {
    if [[ -f "/etc/gotpl/$1" ]]; then
        gotpl "/etc/gotpl/$1" > "$2"
    fi
}

sudo fix-permissions.sh www-data www-data "${WODBY_DIR_FILES}"
mkdir -p "${WODBY_DIR_FILES}/private" "${WODBY_DIR_FILES}/public"

if [[ -n "${WODBY_APP_NAME}" && -n "${WP_VERSION}" ]]; then
    exec_tpl "wodby.wp${WP_VERSION}-config.php.tpl" "${WODBY_DIR_CONF}/wodby.wp-config.php"
    exec_tpl "wp-config.php.tpl" "${WODBY_DIR_CONF}/wp-config.php"
fi
