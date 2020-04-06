#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

_gotpl() {
    if [[ -f "/etc/gotpl/$1" ]]; then
        gotpl "/etc/gotpl/$1" > "$2"
    fi
}

# Remove generic environment config from wodby/php
rm -f "${CONF_DIR}/wodby.settings.php"

if [[ -n "${WODBY_APP_NAME}" && -n "${WP_VERSION}" ]]; then
    _gotpl "wodby.wp-config.php.tmpl" "${CONF_DIR}/wodby.wp-config.php"
    _gotpl "wp-config.php.tmpl" "${CONF_DIR}/wp-config.php"
fi
