#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

source=$1

tmp_source_dir="/tmp/source"
tmp_dir="/tmp/duplicator"

[[ -d "${tmp_source_dir}" ]] && rm -rf "${tmp_source_dir}"

mkdir -p "${tmp_source_dir}"

if [[ "${source}" =~ ^https?:// ]]; then
    wget -q -P "${tmp_source_dir}" "${source}"
else
    mv "${source}" "${tmp_source_dir}"
fi

archive_file=$(find "${tmp_source_dir}" -type f)

if [[ ! "${archive_file}" =~ \.zip$ ]]; then
    echo >&2 'Unsupported file format. Expecting .zip duplicator archive'
    exit 1
else
    mkdir -p "${tmp_dir}"
    unzip "${archive_file}" -q -d "${tmp_dir}"
fi

# Import db.
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" -e "DROP DATABASE IF EXISTS ${DB_NAME};"
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" -e "CREATE DATABASE ${DB_NAME};"
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" < "${tmp_dir}/database.sql"

# Import files.
if [[ -d "${tmp_dir}/wp-content/uploads" ]]; then
    rsync -rlt --delete --force "${tmp_dir}/wp-content/uploads/" "${WODBY_DIR_FILES}/public/"
    rm -rf "${tmp_dir}/wp-content/uploads"
fi

rm -rf "${tmp_source_dir}"
rm -rf "${tmp_dir}"
