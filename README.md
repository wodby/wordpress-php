# PHP for WordPress Docker Container Image

[![Build Status](https://github.com/wodby/wordpress-php/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/wordpress-php/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)

## Docker Images

❗For better reliability we release images with stability tags (`wodby/wordpress-php:8.0-X.X.X`) which correspond
to [git tags](https://github.com/wodby/wordpress-php/releases). We strongly recommend using images only with stability
tags.

Overview:

- All images based on Alpine Linux
- Base image: [wodby/php](https://github.com/wodby/php)
- [GitHub actions builds](https://github.com/wodby/wordpress-php/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/wordpress-php)

[_(Dockerfile)_]: https://github.com/wodby/wordpress-php/tree/master/Dockerfile

Supported tags and respective `Dockerfile` links:

- `8.1-alpine3.15`, `8-alpine3.15`, `8.1-alpine`, `8-alpine`, `8.1`, `8`, `alpine3.15`, `alpine`, `latest` [_(Dockerfile)_]
- `8.0-alpine3.15`, `8.0-alpine`, `8.0` [_(Dockerfile)_]
- `7.4-alpine3.15`, `7-alpine3.15`, `7.4-alpine`, `7-alpine`, `7.4`, `7` [_(Dockerfile)_]
- `8.1-dev-alpine3.15`, `8-dev-alpine3.15`, `dev-alpine3.15`, `8.1-dev-alpine`, `8-dev-alpine`, `dev-alpine`, `8.1-dev`, `8-dev`, `dev` [_(Dockerfile)_]
- `8.0-dev-alpine3.15`, `8.0-dev-alpine`, `8.0-dev` [_(Dockerfile)_]
- `7.4-dev-alpine3.15`, `7-dev-alpine3.15`, `7.4-dev-alpine`, `7-dev-alpine`, `7.4-dev`, `7-dev` [_(Dockerfile)_]
- `8.1-dev-macos-alpine3.15`, `8-dev-macos-alpine3.15`, `dev-macos-alpine3.15`, `8.1-dev-macos-alpine`, `8-dev-macos-alpine`, `dev-macos-alpine`, `8.1-dev-macos`, `8-dev-macos`, `dev-macos` [_(Dockerfile)_]
- `8.0-dev-macos-alpine3.15`, `8.0-dev-macos-alpine`, `8.0-dev-macos` [_(Dockerfile)_]
- `7.4-dev-macos-alpine3.15`, `7-dev-macos-alpine3.15`, `7.4-dev-macos`, `7-dev-macos` [_(Dockerfile)_]
- `8.1-alpine3.13`, `8-alpine3.13`, `alpine3.13` [_(Dockerfile)_]
- `8.0-alpine3.13` [_(Dockerfile)_]
- `7.4-alpine3.13`, `7-alpine3.13` [_(Dockerfile)_]

All images built for `linux/amd64` and `linux/arm64`

## Tools

This image comes with [WP CLI](https://github.com/wp-cli/wp-cli) version 2.6.0

## Environment Variables

See at [wodby/php](https://github.com/wodby/php)

## Orchestration Actions

Usage:

```
make COMMAND [params ...]
 
commands:
    duplicator-import source
    init-wordpress   
    cache-clear
    
default params values:
    target all
    is_hash 0 
```

See [wodby/php](https://github.com/wodby/php) for all actions

## Complete WordPress Stack

See [Docker4WordPress](https://github.com/wodby/docker4wordpress).
