default:
	$(MAKE) start

start:
	docker-sync-stack start

stop:
	docker-sync-stack clean

reset:
    git reset --hard
    git clean -f -d
	rm -rf $$(pwd)/vendor
	git clone -b 3.1 https://github.com/oroinc/crm-application.git tmp
	rsync -ravz tmp/ . --exclude=".git"
	php -d memory_limit=8192 /usr/local/bin/composer install --no-dev -vvv --profile

clean :
	docker-sync clean
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true