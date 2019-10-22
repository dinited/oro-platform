default:
	$(MAKE) local

remote:
	export ORO_APP=$$(pwd)
	docker-compose up -d

local:
	export ORO_APP=$$(pwd); docker-sync-stack start

down:
	docker-compose down

install:
	php -d memory_limit=8192 /usr/local/bin/composer install --no-dev -vvv --profile

clean :
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker volume prune -f
	docker network prune -f