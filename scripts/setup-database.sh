#!/bin/bash
set -e

echo "Dropping DB"
./manage.py reset_db --noinput

echo "Collecting static files..."
./manage.py collectstatic --noinput

echo "Running migrations"
./manage.py migrate

echo "Running command..."
./manage.py populate_database
