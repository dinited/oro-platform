default:
	$(MAKE) start

start:
	export BUILD_DIR=$(pwd)/.build && docker-compose -f docker-compose.yml pull && docker-compose -f docker-compose.yml up -d

stop:
	docker-compose -f docker-compose.yml down

clean:
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker volume prune -f