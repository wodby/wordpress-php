#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

if [[ "${DOCROOT_SUBDIR}" == "" ]]; then
	WP_ROOT="${DOCROOT_SUBDIR}"
else
	WP_ROOT="${APP_ROOT}/${DOCROOT_SUBDIR}"
fi

WP_DOMAIN="$( echo "${BASE_URL}" | sed 's/https\?:\/\///' )"

wp cli --path="${WP_ROOT}" version | grep -q 'WP-CLI'

echo -n "Checking imported files... "
curl -s -I -H "host: ${WP_DOMAIN}" "nginx/wp-content/uploads/public/logo.png" | grep -q "200 OK"
echo "OK"

echo -n "Checking Drupal homepage... "
curl -s -H "host: ${WP_DOMAIN}" "nginx" | grep -q "Welcome to WordPress"
echo "OK"
