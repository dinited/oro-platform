.ONESHELL:
SHELL := /bin/bash

default:
	docker-compose -f docker-compose.yml down
	docker-compose -f docker-compose.yml pull
	docker-compose -f docker-compose.yml up --force-recreate -d
	source ./.env; until [ "$$DEBUGGER" = false ]; do DEBUGGER="$$(docker inspect -f '{{.State.Running}}' $${DOCKERPREFIX}_debug_1)"; echo "sync in progress"; sleep 5; done

stop:
	docker-compose -f docker-compose.yml down

clean:
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker volume prune -f