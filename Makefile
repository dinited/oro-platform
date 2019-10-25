default:
	$(MAKE) start

start:
	docker-sync-stack start

stop:
	docker-sync-stack clean

install:
	rm -rf $$(pwd)/vendor
	php -d memory_limit=8192 /usr/local/bin/composer install --no-dev -vvv --profile

clean :
	docker-sync clean
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true