#!/bin/bash

APP_PORT=${PORT:-8000}

echo "Collecting static files..."
./manage.py collectstatic --noinput

echo "Running migrations..."
./manage.py migrate

echo "Starting the server..."
gunicorn --worker-tmp-dir /dev/shm mysite.wsgi:application --bind "0.0.0.0:${APP_PORT}"