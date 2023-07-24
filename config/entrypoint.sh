#!/bin/bash
APP_PORT=${PORT:-8000}
cd /app/
/opt/virtualenv/bin/python manage.py migrate
/opt/virtualenv/bin/gunicorn --worker-tmp-dir /dev/shm mysite.wsgi:application --bind "0.0.0.0:${APP_PORT}"