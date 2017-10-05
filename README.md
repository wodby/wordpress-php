# PHP for WordPress Docker Container Image

[![Build Status](https://travis-ci.org/wodby/wordpress-php.svg?branch=master)](https://travis-ci.org/wodby/wordpress-php)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/wordpress-php.svg)](https://hub.docker.com/r/wodby/wordpress-php)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

* All images are based on Alpine Linux
* Base image: [wodby/php](https://github.com/wodby/php)
* [Travis CI builds](https://travis-ci.org/wodby/wordpress-php) 
* [Docker Hub](https://hub.docker.com/r/wodby/wordpress-php)

For better reliability we release images with stability tags (`wodby/wordpress-php:7.1-X.X.X`) which correspond to git tags. We **strongly recommend** using images only with stability tags. Below listed basic tags:

| Image tag (Dockerfile)                                                     | PHP |
| -------------------------------------------------------------------------- | --- |
| [7.1](https://github.com/wodby/wordpress-php/tree/master/Dockerfile)       | 7.1 |
| [7.0](https://github.com/wodby/wordpress-php/tree/master/Dockerfile)       | 7.0 |
| [5.6](https://github.com/wodby/wordpress-php/tree/master/Dockerfile)       | 5.6 |
| [7.1-debug](https://github.com/wodby/wordpress-php/tree/master/Dockerfile) | 7.1 |
| [7.0-debug](https://github.com/wodby/wordpress-php/tree/master/Dockerfile) | 7.0 |
| [5.6-debug](https://github.com/wodby/wordpress-php/tree/master/Dockerfile) | 5.6 |

> Images with -debug tag run php compiled with --enable-debug flag

See [wodby/php](https://github.com/wodby/php) for the exact PHP version

## Tools

[WP CLI]: https://packagist.org/packages/wp-cli/wp-cli

| Tool                       | 7.1     | 7.0     | 5.6     |
| -------------------------- | ------- | ------- | ------- |
| [WP CLI]                   | latest  | latest  | latest  |

## Environment Variables

See at [wodby/php](https://github.com/wodby/php)

## Complete WordPress Stack

See [Docker4WordPress](https://github.com/wodby/docker4wordpress).