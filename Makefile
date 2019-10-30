default:
	export VOLUME=opv31-demo; $(MAKE) start

start:
	docker-compose -f docker-compose.yml pull
	docker-compose -f docker-compose.yml up --force-recreate -d
	until [ "$$DEBUGGER" = false ]; do DEBUGGER="$$(docker inspect -f '{{.State.Running}}' oro-platform-demo_debug_1)"; echo "sync in progress"; sleep 5; done

stop:
	docker-compose -f docker-compose.yml down

clean:
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker volume prune -f