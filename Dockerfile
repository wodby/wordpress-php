ARG BASE_IMAGE_TAG

FROM wodby/php:${BASE_IMAGE_TAG}

USER root

RUN set -ex; \
    \
    apk add --no-cache -t .fetch-deps gnupg; \
    \
    cd /tmp; \
    wp_cli_version="2.6.0"; \
    url="https://github.com/wp-cli/wp-cli/releases/download/v${wp_cli_version}/wp-cli-${wp_cli_version}.phar"; \
    curl -o wp.phar -fSL "${url}"; \
    curl -o wp.phar.asc -fSL "${url}.asc"; \
    \
    GPG_KEYS=63AF7AA15067C05616FDDD88A3A2E8F226F0BC06 gpg_verify /tmp/wp.phar.asc /tmp/wp.phar; \
    \
    sha512="d73f9161a1f03b8ecaac7b196b6051fe847b3c402b9c92b1f6f3acbe5b1cf91f7260c0e499b8947bab75920ecec918b39533ca65fa5a1fd3eb6ce7b8e2c58e7d"; \
	echo "${sha512} *wp.phar" | sha512sum -c -; \
	\
    chmod +x wp.phar; \
    mv wp.phar /usr/local/bin/wp; \
    \
    url="https://raw.githubusercontent.com/wp-cli/wp-cli/v${wp_cli_version}/utils/wp-completion.bash"; \
    curl -o /usr/local/include/wp-completion.bash -fSL "${url}"; \
    cd /home/wodby; \
    echo "source /usr/local/include/wp-completion.bash" | tee -a .bash_profile .bashrc; \
    \
    if [[ -z "${PHP_DEV}" ]]; then \
        echo "$(cat /etc/sudoers.d/wodby), /usr/local/bin/init_wordpress" > /etc/sudoers.d/wodby; \
    fi; \
    \
    mv /usr/local/bin/actions.mk /usr/local/bin/php.mk; \
    \
    apk del --purge .fetch-deps; \
    rm -rf /var/cache/apk/* /tmp/*

USER wodby

COPY templates /etc/gotpl/
COPY bin /usr/local/bin
COPY init /docker-entrypoint-init.d/