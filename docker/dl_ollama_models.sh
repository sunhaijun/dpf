#!/bin/bash

set -e

# run ollama
docker run -d -v ./deploy_pkg/ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

# pull models inside the container
docker exec ollama ollama pull qwen2
docker exec ollama ollama pull qwen2:1.5b

# stop ollama & remove container
docker stop ollama
docker rm ollama

echo "Done."