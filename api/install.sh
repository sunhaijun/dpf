#!/bin/bash

set -e

# install dependencies (including PostgreSQL, Redis, and Weaviate)
cd ../docker

# for clean dev environment
# rm -rf volumes/db
# rm -rf volumes/redis
# rm -rf volumes/weaviate

#cp middleware.env.example middleware.env
docker compose -f docker-compose.middleware.yaml --profile weaviate -p dpf up -d

cd ../api
poetry env use 3.10
poetry install

# Migrate the database
poetry run python -m flask db upgrade

# Start backend
poetry run python -m flask run --host 0.0.0.0 --port=5001 --debug

# If you need to debug local async processing, please start the worker service
poetry run python -m celery -A app.celery worker -P gevent -c 1 --loglevel INFO -Q dataset,generation,mail,ops_trace,app_deletion




