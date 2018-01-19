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

# Remove generic environment config from wodby/php
rm -f "${CONF_DIR}/wodby.settings.php"

if [[ -n "${WODBY_APP_NAME}" && -n "${WP_VERSION}" ]]; then
    exec_tpl "wodby.wp${WP_VERSION}-config.php.tpl" "${CONF_DIR}/wodby.wp-config.php"
    exec_tpl "wp-config.php.tpl" "${CONF_DIR}/wp-config.php"
fi
