#!/bin/bash

echo "Waiting for database..."
while ! nc -z db 5432; do
  sleep 0.1
done
echo "Database is ready!"

echo "Applying database migrations..."
python manage.py migrate

echo "Starting server..."
python manage.py runserver 0.0.0.0:8000