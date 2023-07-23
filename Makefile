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

# Start project.
start:
	${DC} up --remove-orphans

# Exec bash shell on django container.
shell:
	${DC} run --user ${UID} --rm django bash

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