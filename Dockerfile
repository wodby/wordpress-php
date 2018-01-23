ARG BASE_IMAGE_TAG

FROM wodby/php:${BASE_IMAGE_TAG}

USER root

RUN set -ex; \
    \
    su-exec www-data composer global require wp-cli/wp-cli; \
    su-exec www-data composer clear-cache; \
    \
    mv /usr/local/bin/actions.mk /usr/local/bin/php.mk

USER www-data

COPY templates /etc/gotpl/
COPY actions /usr/local/bin
COPY init /docker-entrypoint-init.d/