#Explicitly delclare shell
SHELL :=/bin/bash

#Api definition


OPEN_API :=openapi.json
GIT_HASH :=$(shell git rev-parse HEAD)
GITHUB_USER := KOUNT
COMMIT_MESSAGE ?= "updating client ${GIT_HASH}"

#Language specific has to match packagePath in config
PHP_PROJECT :=login-php

push: php-push #java-push
build: php-build #java-build
clone: php-clone #java-clone
clean: php-clean #java-clean

#PHP client generation
php-push: php-build
	cd ${PHP_PROJECT};\
	cp ../git-helper.sh ./;\
	${SHELL} ./git-helper.sh ${GITHUB_USER} ${PHP_PROJECT} ${COMMIT_MESSAGE};
	
php-build: php-clone
	swagger-codegen generate -i ${OPEN_API} -l php  -c php-config.json -a "Authorization:Bearer"

php-clone: php-clean
	git clone git@github.com:${GITHUB_USER}/${PHP_PROJECT}.git

php-clean: 
	rm -rf ./${PHP_PROJECT}


#java-push:
#java-build:
#java-clone: 
#java-clean:
.PHONY: php-push php-build php-clean

