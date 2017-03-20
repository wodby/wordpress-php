#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

rm -f "${WP_ROOT}/wp-content/uploads"
ln -sf "${WODBY_DIR_FILES}/public" "${WP_ROOT}/wp-content/uploads"
