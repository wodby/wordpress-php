-include env_make

VERSION ?= 5.6

REPO = wodby/wordpress-php
NAME = wordpress-php-$(VERSION)
DEBUG = 0
BASE_IMAGE = wodby/php:5.6

ifeq ($(DEBUG), 1)
	override VERSION := $(VERSION)-debug
	BASE_IMAGE := $(BASE_IMAGE)-debug
	NAME := $(NAME)-debug
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(VERSION) --build-arg BASE_IMAGE=$(BASE_IMAGE) ./

test:
	cd ./test/4 && IMAGE=$(REPO):$(VERSION) ./run.sh

push:
	docker push $(REPO):$(VERSION)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(VERSION)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
