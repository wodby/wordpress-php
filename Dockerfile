ARG FROM_TAG

FROM wodby/php:${FROM_TAG}

USER root

RUN set -ex; \
    \
    su-exec www-data composer global require wp-cli/wp-cli; \
    su-exec www-data composer clear-cache; \
    \
    mv /usr/local/bin/actions.mk /usr/local/bin/php.mk; \
    # Change overridden target name to avoid warnings.
    sed -i 's/git-checkout:/php-git-checkout:/' /usr/local/bin/php.mk

USER www-data

COPY templates /etc/gotpl/
COPY actions /usr/local/bin
COPY init /docker-entrypoint-init.d/