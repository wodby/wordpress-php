# PHP for WordPress Docker Container Image

[![Build Status](https://github.com/wodby/wordpress-php/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/wordpress-php/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)

## Docker Images

Use image revision tags such as `wodby/wordpress-php:8.5-rN` to select a Wodby image revision.
Major and minor tags use the repository release number. Full-version tags such as
`wodby/wordpress-php:8.5.10-r0` start at `r0` for each exact upstream version.
Every published versioned revision tag has a matching annotated Git tag pointing to its release commit.
Existing tags remain available after support for their major or minor version ends.
See [release tags](https://github.com/wodby/wordpress-php/tags) for available revisions and the [image revision policy](https://github.com/wodby/images#image-revisions) for upgrade guidance.
Previously published image tags remain available.

Overview:

- All images based on Alpine Linux
- Base image: [wodby/php](https://github.com/wodby/php)
- [GitHub actions builds](https://github.com/wodby/wordpress-php/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/wordpress-php)

[_(Dockerfile)_]: https://github.com/wodby/wordpress-php/tree/master/Dockerfile

Supported tags and respective `Dockerfile` links:

- `8.5`, `8`, `latest` [_(Dockerfile)_]
- `8.4` [_(Dockerfile)_]
- `8.3` [_(Dockerfile)_]
- `8.2` [_(Dockerfile)_]
- `8.5-dev`, `8-dev`, `dev` [_(Dockerfile)_]
- `8.4-dev` [_(Dockerfile)_]
- `8.3-dev` [_(Dockerfile)_]
- `8.2-dev` [_(Dockerfile)_]
- `8.5-dev-macos`, `8-dev-macos`, `dev-macos` [_(Dockerfile)_]
- `8.4-dev-macos` [_(Dockerfile)_]
- `8.3-dev-macos` [_(Dockerfile)_]
- `8.2-dev-macos` [_(Dockerfile)_]

All images built for `linux/amd64` and `linux/arm64`

## Tools

This image comes with [WP CLI](https://github.com/wp-cli/wp-cli) version 2.12.0

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

## Building with pinned base images

Build with the Makefile to use the base image digests in `base-images.mk`. Local
builds and CI resolve the same version and variant to the same multi-platform
image. A version without a pin fails before the build starts.

When adding a supported base version or variant, add its image index digest to
`base-images.mk`. For a custom build, override `BASE_IMAGE` with a complete
`repository:tag@sha256:...` reference.
