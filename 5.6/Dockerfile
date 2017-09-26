ARG FROM_TAG

FROM wodby/php:${FROM_TAG}

ENV WODBY_DIR_FILES /mnt/files
ENV WODBY_DIR_CONF /var/www/conf

RUN su-exec www-data composer global require wp-cli/wp-cli && \
    su-exec www-data composer clear-cache && \
    mv /usr/local/bin/actions.mk /usr/local/bin/php.mk && \
    # Change overridden target name to avoid warnings.
    sed -i 's/git-checkout:/php-git-checkout:/' /usr/local/bin/php.mk && \
    mkdir -p $WODBY_DIR_FILES $WODBY_DIR_CONF && \
    chown -R www-data:www-data $WODBY_DIR_CONF

COPY templates /etc/gotpl/
COPY actions /usr/local/bin
COPY init /docker-entrypoint-init.d/