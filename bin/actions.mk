-include /usr/local/bin/php.mk

.PHONY: duplicator-import init-wordpress cache-clear

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Required parameter is missing: $1$(if $2, ($2))))

ifeq ("$(DOCROOT_SUBDIR)", "")
    WP_ROOT=$(APP_ROOT)
else
    WP_ROOT="$(APP_ROOT)/$(DOCROOT_SUBDIR)"
endif

default: cache-clear

duplicator-import:
	$(call check_defined, source)
	duplicator_import $(source)

init-wordpress:
	WP_ROOT=$(WP_ROOT) sudo -E init_wordpress

# WordPress core sits in the web root, or in its wp subdirectory in a Composer project that keeps wp-content apart.
WP_CORE=$$(test -f $(WP_ROOT)/wp/wp-settings.php && echo $(WP_ROOT)/wp || echo $(WP_ROOT))

cache-clear:
	wp cache flush --path=$(WP_CORE)
