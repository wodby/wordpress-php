-include env_make

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

ifneq ($(BASE_IMAGE_STABILITY_TAG),)
    BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)-$(BASE_IMAGE_STABILITY_TAG)
endif

IMAGETOOLS_TAG ?= $(TAG)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build buildx-build buildx-push test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) ./

buildx-build:
	docker buildx build \
		--platform $(PLATFORM) \
		--build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
		-t $(REPO):$(TAG) ./

buildx-push:
	docker buildx build --push \
		--platform $(PLATFORM) \
		--build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
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
