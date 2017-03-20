#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

wp_config="${WP_ROOT}/wp-config.php"

if [[ ! -f "${wp_config}" ]] || [[ $( grep -ic "wodby.wp-config.php.tpl" "${wp_config}" ) -eq 0 ]]; then
    cp -f "${WODBY_DIR_CONF}/wp-config.php" "${wp_config}"
    chmod 644 "${wp_config}"
fi

wp --path="${WP_ROOT}" option update home "${BASE_URL}"
wp --path="${WP_ROOT}" option update siteurl "${BASE_URL}"

exec init-files.sh
