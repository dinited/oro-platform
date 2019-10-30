default:
	export BUILD_DIR=$$(pwd)/.build;$(MAKE) start

start:
	cp config/parameters.yml.demo $(BUILD_DIR)/config/parameters.yml
	docker-compose -f docker-compose.yml pull
	docker-compose -f docker-compose.yml up --force-recreate -d
	until [ "$$DEBUGGER" = false ]; do DEBUGGER="$$(docker inspect -f '{{.State.Running}}' oro-platform-demo_debug_1)"; echo "sync in progress"; sleep 5; done
	docker exec oro-platform-demo_php_1
    docker exec -it oro_php_1 sh -c "apt-get update; apt-get install sudo;"
    docker exec -it oro_php_1 sh -c "rm -rf vendor/oro/platform/build/node_modules"
    docker exec -it oro-platform-demo_php_1 sh -c "sudo -u www-data sh -c "php bin/console cache:clear""
    docker exec -it oro-platform-demo_php_1 sh -c "sudo -u www-data sh -c "php bin/console oro:assets:install""
    docker exec -it oro-platform-demo_php_1 sh -c "cp /var/www/debug/public/index.php /var/www/html/application/public/index.php"

stop:
	docker-compose -f docker-compose.yml down

clean:
	docker stop $$(docker ps -a -q) 2>/dev/null || true
	docker rm $$(docker ps -a -q) 2>/dev/null || true
	docker volume prune -f