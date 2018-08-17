ARG BASE_IMAGE_TAG

FROM wodby/php:${BASE_IMAGE_TAG}

USER root

ENV WP_CLI_VERSION="2.0.0"

RUN set -ex; \
    \
    apk add --no-cache -t .fetch-deps gnupg; \
    \
    url="https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar.gpg"; \
    curl -o /usr/local/bin/wp.gpg -fSL "${url}"; \
    \
    gpg_key="63AF7AA15067C05616FDDD88A3A2E8F226F0BC06"; \
    export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${gpg_key}"; \
	gpg --batch --decrypt --output /usr/local/bin/wp /usr/local/bin/wp.gpg; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/wp.gpg; \
	\
    sha512="18c15c792a0747e434f70fb74f8d82dbc6dc504bd6238a4928859430129f12d88d829a1f37203c30813eb5f4d2c69f4e40aa15c74d9c6f01343052f01842463b"; \
	echo "${sha512} */usr/local/bin/wp" | sha512sum -c -; \
	chmod +x /usr/local/bin/wp; \
    \
    if [[ -z "${PHP_DEV}" ]]; then \
        echo "$(cat /etc/sudoers.d/wodby), /usr/local/bin/init_wordpress" > /etc/sudoers.d/wodby; \
    fi; \
    \
    mv /usr/local/bin/actions.mk /usr/local/bin/php.mk; \
    \
    apk del --purge .fetch-deps; \
    rm -rf /var/cache/apk/*

USER wodby

COPY templates /etc/gotpl/
COPY bin /usr/local/bin
COPY init /docker-entrypoint-init.d/