#!/usr/bin/env bash

# TODO: test redis and varnish plugins, create duplicator archive from CLI.

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

run_action() {
    make "${@}" -f /usr/local/bin/actions.mk
}

if [[ "${DOCROOT_SUBDIR}" == "" ]]; then
	WP_ROOT="${APP_ROOT}"
else
	WP_ROOT="${APP_ROOT}/${DOCROOT_SUBDIR}"
fi

WP_DOMAIN="$( echo "${BASE_URL}" | sed 's/https\?:\/\///' )"

cd "${WP_ROOT}"

wp cli version | grep -q 'WP-CLI'

wp core download
wp core config --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}" --dbhost="${DB_HOST}"
wp core install --url="${BASE_URL}" --title="WordPress" --admin_user=admin --admin_password=admin --admin_email=admin@example.com
wp core is-installed

DUPLICATOR_ARCHIVE_URL="https://s3-us-west-1.amazonaws.com/wodby-presets/wordpress${WP_VERSION}/wodby-wordpress${WP_VERSION}-latest.zip"
FILES_ARCHIVE_URL="https://s3.amazonaws.com/wodby-sample-files/drupal-php-import-test/files.tar.gz"

run_action duplicator-import source="${DUPLICATOR_ARCHIVE_URL}"

# TODO: build new sample duplicator archive from new vanilla image (normally should be w/o uploads dir)
rm -rf "${WP_ROOT}/wp-content/uploads"

run_action files-import source="${FILES_ARCHIVE_URL}"
run_action init-wordpress
run_action cache-clear

wp core is-installed
rm wp-config.php
run_action init-wordpress
wp core is-installed

echo -n "Checking imported files... "
curl -s -I -H "host: ${WP_DOMAIN}" "nginx/wp-content/uploads/logo.png" | grep -q "200 OK"
echo "OK"

echo -n "Checking WordPress homepage... "
curl -s -H "host: ${WP_DOMAIN}" "nginx" | grep -q "Welcome to WordPress"
echo "OK"
