-include env_make

# Accept legacy build arguments during the image revision transition.
BASE_IMAGE_REVISION ?= $(BASE_IMAGE_STABILITY_TAG)

PHP_VER ?= 8.5

BASE_IMAGE_TAG = $(PHP_VER)
REGISTRY ?= docker.io
REPO = $(REGISTRY)/wodby/wordpress-php
NAME = wordpress-php-$(PHP_VER)

PLATFORM ?= linux/arm64

ifeq ($(TAG),)
    ifneq ($(PHP_DEBUG),)
        TAG = $(PHP_VER)-debug
    else ifneq ($(PHP_DEV_MACOS),)
    	TAG = $(PHP_VER)-dev-macos
    else ifneq ($(PHP_DEV),)
        TAG = $(PHP_VER)-dev
    else
        TAG = $(PHP_VER)
    endif
endif

ifneq ($(PHP_DEV_MACOS),)
    NAME := $(NAME)-dev-macos
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-dev-macos
else ifneq ($(PHP_DEV),)
    NAME := $(NAME)-dev
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-dev
else ifneq ($(PHP_DEBUG),)
    NAME := $(NAME)-debug
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-debug
endif

ifneq ($(BASE_IMAGE_REVISION),)
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-$(BASE_IMAGE_REVISION)
endif

IMAGETOOLS_TAG ?= $(TAG)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build buildx-build buildx-push test push shell run start stop logs clean release

# Resolve the same pinned base image for every local and CI build target.
include base-images.mk

default: build

build:
	docker build --build-arg BASE_IMAGE="$(BASE_IMAGE)" -t $(REPO):$(TAG) ./

buildx-build:
	docker buildx build --build-arg BASE_IMAGE="$(BASE_IMAGE)" \
		--platform $(PLATFORM) \
		-t $(REPO):$(TAG) ./

buildx-push:
	docker buildx build --build-arg BASE_IMAGE="$(BASE_IMAGE)" --push \
		--platform $(PLATFORM) \
		-t $(REPO):$(TAG) ./

buildx-imagetools-create:
	docker buildx imagetools create -t $(REPO):$(IMAGETOOLS_TAG) \
				  $(REPO):$(TAG)-amd64 \
				  $(REPO):$(TAG)-arm64
.PHONY: buildx-imagetools-create 

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) ./run.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
