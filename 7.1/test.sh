#!/usr/bin/env bash

set -ex

make run -e CMD='wp cli version' | grep 'WP-CLI'
