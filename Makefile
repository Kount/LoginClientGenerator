
OPEN_API=openapi.json
PHP_BUILDDIR=login-php
GIT_HASH=$(shell git rev-parse HEAD)
COMMIT_MESSAGE ?= "updating client ${GIT_HASH}"

php-push: php-build
	cd ${PHP_BUILDDIR}
	/bin/sh ./git_push.sh Kount login-php ${COMMIT_MESSAGE}

	
php-build: php-clean
	swagger-codegen generate -i ${OPEN_API} -l php  -c php-config.json

php-clean: 
	rm -rf ./${PHP_BUILDDIR}


#java-push
#java-build
#java-clean
