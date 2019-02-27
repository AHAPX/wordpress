install:
	apt-get update && apt-get install -y apt-transport-https ca-certificates curl
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
	apt-get update && apt-get install -y docker-engine
	curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	cp docker-compose.override.yml.sample docker-compose.override.yml
	cp nginx/conf.d/default.template.sample nginx/conf.d/default.template
	@echo -e '\e[00;31m===============================================================================================\e[00m'
	@echo -e '\e[00;31mDO NOT FORGET TO CHECK CONFIG FILES: docker-compose.override.yml, nginx/conf.d/default.template\e[00m'
	@echo -e '\e[00;31m===============================================================================================\e[00m'
up:
	docker-compose build
	docker-compose up -d
down:
	docker-compose down
reboot:
	make down
	make up
restart:
	docker-compose restart $(dock)
logs:
	docker-compose logs -f --tail 30 $(dock)
backup:
	@mkdir -p backups
	@tar czf backups/`date +%Y%m%d%H%M%S`.tgz mysql/data/ wordpress/ nginx/ docker-compose.override.yml
	@echo 'Backup done'
restore:
	@test -s $(file) || { echo -e 'File "$(file)" not found'; exit 1; }
	@rm -rf mysql/data/ wordpress/ nginx/
	@tar xzf $(file) -C ./
	@echo 'Restored successful'
