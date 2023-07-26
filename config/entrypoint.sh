#!/bin/bash
cd /app/

APP_PORT=${PORT:-8000}

echo "Collecting static files..."
/opt/virtualenv/bin/python manage.py collectstatic --noinput

echo "Running migrations..."
/opt/virtualenv/bin/python manage.py migrate

echo "Starting the server..."
/opt/virtualenv/bin/gunicorn --worker-tmp-dir /dev/shm mysite.wsgi:application --bind "0.0.0.0:${APP_PORT}"