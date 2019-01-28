ARG BASE_IMAGE_TAG

FROM wodby/php:${BASE_IMAGE_TAG}

USER root

RUN set -ex; \
    \
    apk add --no-cache -t .fetch-deps gnupg; \
    \
    cd /tmp; \
    wp_cli_version="2.1.0"; \
    url="https://github.com/wp-cli/wp-cli/releases/download/v${wp_cli_version}/wp-cli-${wp_cli_version}.phar"; \
    curl -o wp.phar -fSL "${url}"; \
    curl -o wp.phar.asc -fSL "${url}.asc"; \
    \
    GPG_KEYS=63AF7AA15067C05616FDDD88A3A2E8F226F0BC06 gpg_verify /tmp/wp.phar.asc /tmp/wp.phar; \
    \
    sha512="c2ff556c21c85bbcf11be38d058224f53d3d57a1da45320ecf0079d480063dcdc11b5029b94b0b181c1e3bec84745300cd848d28065c0d3619f598980cc17244"; \
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