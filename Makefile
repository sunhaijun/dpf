# Variables
PLATFORMS="linux/amd64,linux/arm64"
DOCKER_REGISTRY=registry.ware.cloud
WEB_IMAGE=$(DOCKER_REGISTRY)/dpf-web
API_IMAGE=$(DOCKER_REGISTRY)/dpf-api
VERSION=1.0.1

# Build Docker images
build-web:
	@echo "Building web Docker image: $(WEB_IMAGE):$(VERSION)..."
	docker buildx build --platform $(PLATFORMS) -t registry.ware.cloud/$(WEB_IMAGE):$(VERSION) --build-arg APP_VERSION=$(VERSION) ./web
	@echo "Web Docker image built successfully: $(WEB_IMAGE):$(VERSION)"

build-api:
	@echo "Building API Docker image: $(API_IMAGE):$(VERSION)..."
	docker buildx build --platform $(PLATFORMS) -t registry.ware.cloud/$(API_IMAGE):$(VERSION) --build-arg APP_VERSION=$(VERSION) ./api
	@echo "API Docker image built successfully: $(API_IMAGE):$(VERSION)"

# Push Docker images
push-web:
	@echo "Pushing web Docker image: $(WEB_IMAGE):$(VERSION)..."
	docker push registry.ware.cloud/$(WEB_IMAGE):$(VERSION)
	@echo "Web Docker image pushed successfully: $(WEB_IMAGE):$(VERSION)"

push-api:
	@echo "Pushing API Docker image: $(API_IMAGE):$(VERSION)..."
	docker push registry.ware.cloud/$(API_IMAGE):$(VERSION)
	@echo "API Docker image pushed successfully: $(API_IMAGE):$(VERSION)"

# Build all images
build-all: build-web build-api

# Push all images
push-all: push-web push-api

build-push-api: build-api push-api
build-push-web: build-web push-web

# Build and push all images
build-push-all: build-all push-all
	@echo "All Docker images have been built and pushed."

# Phony targets
.PHONY: build-web build-api push-web push-api build-all push-all build-push-all
