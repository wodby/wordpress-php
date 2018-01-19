#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

source=$1
tmp_dir="/tmp/source"

get-archive.sh "${source}" "${tmp_dir}" "zip tgz tar.gz tar"

# TODO: deprecate /public import from non-wodby backups.
# TODO: use generic files-import.sh from wodby/php
if [[ -d "${tmp_dir}/public" ]]; then
    rsync -rlt --force "${tmp_dir}/public/" "${FILES_DIR}/public/"
else
    rsync -rlt --force "${tmp_dir}/" "${FILES_DIR}/public/"
fi

rm -rf "${tmp_dir}"
