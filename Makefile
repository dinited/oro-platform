default:
	$(MAKE) stack

stack:
    docker-sync start
    docker stack deploy --orchestrator=kubernetes -c docker-compose.yml oro-platform

down:
	docker-compose down

install:
    rm -rf $$(pwd)/vendor
	php -d memory_limit=8192 /usr/local/bin/composer install --no-dev -vvv --profile

clean :
	docker-sync clean
    docker stack rm --orchestrator=kubernetes oro-platform