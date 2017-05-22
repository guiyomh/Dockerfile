ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent
.PHONY: test documentation baselayout provision

help: ## show this help
	@grep -E '^[a-zA-Z_/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

build: immortal php composer

immortal: ## build the guiyomh/immortal immage
	./bin/build.sh -t immortal

php: php/7.2 php-tools ## build the guiyomh/php images

php/7.2: ## build the guiyomh/php:7.2 images
	./bin/build.sh -t php7.2

php-tools: ## build the guiyomh/php-tools images
	./bin/build.sh -t php-tools

composer: ## build the guiyomh/composer images
	./bin/build.sh -t composer

%:
	@:
