# PHP for WordPress Docker Container Image

[![Build Status](https://travis-ci.org/wodby/wordpress-php.svg?branch=master)](https://travis-ci.org/wodby/wordpress-php)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/wordpress-php.svg)](https://microbadger.com/images/wodby/wordpress-php)

## Docker Images

!!! For better reliability we release images with stability tags (`wodby/wordpress-php:7.1-X.X.X`) which correspond to [git tags](https://github.com/wodby/wordpress-php/releases). We **STRONGLY RECOMMEND** using images only with stability tags. 

Overview:

* All images are based on Alpine Linux
* Base image: [wodby/php](https://github.com/wodby/php)
* [Travis CI builds](https://travis-ci.org/wodby/wordpress-php) 
* [Docker Hub](https://hub.docker.com/r/wodby/wordpress-php)

[_(Dockerfile)_]: https://github.com/wodby/wordpress-php/tree/master/Dockerfile

Supported tags and respective `Dockerfile` links:

* `7.2`, `latest` [_(Dockerfile)_]
* `7.1` [_(Dockerfile)_]
* `7.0` [_(Dockerfile)_]
* `5.6` [_(Dockerfile)_]
* `7.2-dev` [_(Dockerfile)_]
* `7.1-dev` [_(Dockerfile)_]
* `7.0-dev` [_(Dockerfile)_]
* `5.6-dev` [_(Dockerfile)_]

For better reliability we additionally release images with stability tags (`wodby/wordpress-php:7.1-X.X.X`) which correspond to git tags. We **strongly recommend** using images only with stability tags. 

## Tools

[WP CLI (latest version)](https://packagist.org/packages/wp-cli/wp-cli)

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
