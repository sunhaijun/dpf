#!/bin/bash

set -e

# install dependencies (including PostgreSQL, Redis, and Weaviate)
cd ../docker
#cp middleware.env.example middleware.env
docker compose -f docker-compose.middleware.yaml --profile weaviate -p dpf up -d
cd ../api

poetry env use 3.10
poetry install

# Migrate the database
poetry run python -m flask db upgrade

# Start backend
poetry run python -m flask run --host 0.0.0.0 --port=5001 --debug


