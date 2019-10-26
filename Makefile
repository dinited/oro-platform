default:
	$(MAKE) start

start:
	docker-sync-stack start

stop:
	docker-sync-stack clean

install:
	docker-sync-stack clean
	docker cp oro_data_1:/var/www/html/spawn/dump.sql

upgrade:
	git reset --hard
	git clean -f -d
	git clone -b 3.1 https://github.com/oroinc/crm-application.git .tmp
	rsync -ravz .tmp/ . --exclude=".git" --exclude=".gitignore" --exclude="composer.json"
	rm -rf .tmp/
	php -d memory_limit=8192 /usr/local/bin/composer global require hirak/prestissimo
	php -d memory_limit=8192 /usr/local/bin/composer install --no-interaction --no-dev -vvv --profile

clean :
	docker-sync clean
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true