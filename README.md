# PHP for WordPress Docker Container Image

[![Build Status](https://travis-ci.org/wodby/wordpress-php.svg?branch=master)](https://travis-ci.org/wodby/wordpress-php)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Layers](https://images.microbadger.com/badges/image/wodby/wordpress-php.svg)](https://microbadger.com/images/wodby/wordpress-php)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

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
* `7.2-debug` [_(Dockerfile)_]
* `7.1-debug` [_(Dockerfile)_]
* `7.0-debug` [_(Dockerfile)_]
* `5.6-debug` [_(Dockerfile)_]

For better reliability we additionally release images with stability tags (`wodby/wordpress-php:7.1-X.X.X`) which correspond to git tags. We **strongly recommend** using images only with stability tags. 

> Images with -debug tag run php compiled with --enable-debug flag

## Tools

[WP CLI (latest version)](https://packagist.org/packages/wp-cli/wp-cli)

## Environment Variables

See at [wodby/php](https://github.com/wodby/php)

## Complete WordPress Stack

See [Docker4WordPress](https://github.com/wodby/docker4wordpress).
