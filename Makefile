default:
	$(MAKE) local

remote:
	export ORO_APP=$$(pwd)
	docker-compose up -d

local:
	docker-sync start
	export ORO_APP=$$(pwd); docker-compose -f docker-compose.yml -f docker-compose-dev.yml up

install:
	docker-sync start
	export ORO_APP=$$(pwd); docker-compose -f docker-compose.yml -f docker-compose-dev.yml -f docker-compose-install.yml up

down:
	docker-compose down

clean :
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker volume prune -f
	docker network prune -f