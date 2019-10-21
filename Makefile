.ONESHELL:
# FORMAT: perl -pi -e 's/^  */\t/' Makefile

default:
	$(MAKE) local

remote:
	export ORO_APP=$$(pwd)
	docker-compose up -d

local:
	export COMPOSER_CACHE_DIR=$$(pwd)
	export ORO_APP=$$(pwd)
	docker-sync-stack start

local-install:
	export COMPOSER_CACHE_DIR=$$(pwd)
	export ORO_APP=$$(pwd)
	docker-sync start --daemon
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml -f docker-compose-install.yml
	php -d memory_limit=8192 /usr/local/bin/composer install --no-dev -vvv --profile

down:
	docker-compose down

clean :
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker image prune -af
	docker network prune -f