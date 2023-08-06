# Check id docker-compose is available else use docker compose
ifeq (, $(shell which docker-compose))
    DC = docker compose
else
    DC = docker-compose
endif
UID = $(shell id -u)

# Build docker images.
build:
	${DC} build --pull

# Download media from remote
get_media:
	./scripts/download_and_apply_media.sh

# Download database from remote
get_db:
	./scripts/download_db_from_remote.sh

# Load dump database
db:
	${DC} run --rm django ./scripts/setup-database.sh

start-prod:
	${DC} -f docker-compose.yaml -f devops/deploy/docker-compose.prod.yml up -d

# Start project.
start:
	${DC} up --remove-orphans

# Exec bash shell on django container.
shell:
	${DC} run --user ${UID} --rm django bash

# Run shell_plus on django container.
# To pass an argument run `make djshell arg=argument`.
# Ex. `make djshell arg=--print-sql`.
djshell:
	${DC} run --rm django python manage.py shell_plus $(arg)

# Run django tests.
test:
	${DC} run django python manage.py test -v 3 $(arg)

# Format python files.
format:
	${DC} run --user ${UID} django bash -c "isort . && black . && flake8 ."

# Check linting.
lint:
	${DC} run django bash -c "isort --check-only . && flake8 ."

# Docker cleaning.
clean:
	docker system prune -a -f --volumes