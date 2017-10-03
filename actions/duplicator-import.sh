#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

source=$1
tmp_dir="/tmp/source"

get-archive.sh "${source}" "${tmp_dir}" "zip"

# Import db.
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" -e "DROP DATABASE IF EXISTS ${DB_NAME};"
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" -e "CREATE DATABASE ${DB_NAME};"
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" < "${tmp_dir}/database.sql"

# Import files.
if [[ -d "${tmp_dir}/wp-content/uploads" ]]; then
    rsync -rlt --force "${tmp_dir}/wp-content/uploads/" "${WODBY_DIR_FILES}/public/"
    rm -rf "${tmp_dir}/wp-content/uploads"
fi

rm -rf "${tmp_dir}"
