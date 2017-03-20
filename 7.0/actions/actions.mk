-include /usr/local/bin/php.mk

.PHONY: duplicator-import files-import cache-clear cache-rebuild

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Required parameter is missing: $1$(if $2, ($2))))

target ?= all

ifeq ("$(DOCROOT_SUBDIR)", "")
	WP_ROOT=$(APP_ROOT)
else
	WP_ROOT="$(APP_ROOT)/$(DOCROOT_SUBDIR)"
endif

default: cache-clear

duplicator-import:
	$(call check_defined, source)
	WP_ROOT=$(WP_ROOT) duplicator-import.sh $(source)

files-import:
	$(call check_defined, source)
	WP_ROOT=$(WP_ROOT) files-import.sh $(source)

cache-clear:
	wp --allow-root cache flush
