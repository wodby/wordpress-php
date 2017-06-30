#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

execTpl() {
    if [[ -f "/etc/gotpl/$1" ]]; then
        gotpl "/etc/gotpl/$1" > "$2"
    fi
}

chown www-data:www-data "${WODBY_DIR_FILES}"

if [[ -n "${WP_VERSION}" ]]; then
    execTpl "wodby.wp${WP_VERSION}-config.php.tpl" "${WODBY_DIR_CONF}/wodby.wp-config.php"
    execTpl "wp-config.php.tpl" "${WODBY_DIR_CONF}/wp-config.php"
fi
