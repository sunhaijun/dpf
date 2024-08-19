#!/bin/bash

set -e

# run ollama
docker run -d -v ./ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

# enter ollama container shell
# docker exec -it ollama /bin/bash

# pull models
# ollama pull qwen2
# ollama pull qwen2:1.5b