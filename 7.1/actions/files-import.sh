#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

source=$1
tmp_dir="/tmp/source"

get-archive.sh "${source}" "${tmp_dir}" "zip tgz tar.gz tar"

if [[ -d "${tmp_dir}/public" ]]; then
    rsync -rlt --force "${tmp_dir}/public/" "${WODBY_DIR_FILES}/public/"
else
    rsync -rlt --force "${tmp_dir}/" "${WODBY_DIR_FILES}/public/"
fi

rm -rf "${tmp_dir}"
