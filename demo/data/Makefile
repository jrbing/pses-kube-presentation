#===============================================================================
# vim: softtabstop=2 shiftwidth=2 noexpandtab fenc=utf-8 spelllang=en nolist
#===============================================================================
# Cheat Sheet - http://www.cheatography.com/bavo-van-achte/cheat-sheets/gnumake/
# Refcard - http://www.schacherer.de/frank/technology/tools/make.html

# Automatic Variables
# -------------------
# $@ – the target filename
# $< – the filename of the first prerequisite
# $? – space-delimited list of all prerequisites

MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
PHONY: *
loadbalancer := $(shell kubectl get service pselasticsearch-lb -o go-template='{{(index .status.loadBalancer.ingress 0).ip}}')

test:  ## Check if Elasticsearch is running
	curl "http://esadmin:esadmin@$(loadbalancer):9200/"

browse:  ## Open the cluster in Cerebro
	open "http://localhost:9000/#/overview?host=http:%2F%2F$(loadbalancer):9200"

getip:  ## Get the IP address of the load balancer
	@echo $(loadbalancer)

load:  ## Update the transform.py script and load the data into Kubernetes
	@sed -i.bak s/XXXX/$(loadbalancer)/g transform.py
	mitmdump --client-replay ptportalregistry.mitm --no-server --scripts transform.py

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
