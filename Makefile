#Explicitly delclare shell
SHELL :=/bin/bash

OPEN_API=openapi.json
GIT_HASH=$(shell git rev-parse HEAD)
COMMIT_MESSAGE ?= "updating client ${GIT_HASH}"

#Language specific has to match packagePath in config
PHP_BUILDDIR=login-php

php-push: php-build
	cd ${PHP_BUILDDIR};\
	pwd;\
	${SHELL} git_push.sh Kount login-php ${COMMIT_MESSAGE};
	
php-build: php-clean
	swagger-codegen generate -i ${OPEN_API} -l php  -c php-config.json

php-clean: 
	rm -rf ./${PHP_BUILDDIR}


#java-push
#java-build
#java-clean
.PHONY: php-push php-build php-clean

