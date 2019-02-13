#===============================================================================
# vim: softtabstop=2 shiftwidth=2 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================
#

MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
REGISTRY_HOST = pseskubedemo.azurecr.io
NAME = ps-elasticsearch-demo
VERSION = 2.3.2
#VERSION ?= latest

.PHONY: build push clean release run help

build:  ## Build the image
	docker build -t $(REGISTRY_HOST)/$(NAME):$(VERSION) .

push:  ## Push the image to the remote repository
	docker push $(REGISTRY_HOST)/$(NAME):$(VERSION)

clean:  ## Remove the local cached image
	docker rmi $(REGISTRY_HOST)/$(NAME):$(VERSION)

release: build  ## Build and push the image
	make push -e VERSION=$(VERSION)

run:  ## Run a container using the generated image
	docker run -it --rm $(REGISTRY_HOST)/$(NAME):$(VERSION) /bin/bash

default: build

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

