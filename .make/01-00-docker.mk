# FYI:
# Naming convention for images is $(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
# e.g.                docker.io/asapdotid/nuxtjs-test:latest
# $(DOCKER_REGISTRY)   ---^        ^       ^     ^      docker.io
# $(DOCKER_NAMESPACE)  ------------^       ^     ^      asapdotid
# $(DOCKER_IMAGE_NAME) --------------------^     ^      nuxtjs-test
# $(DOCKER_IMAGE_TAG)  --------------------------^		latest

TAG:=latest
DOCKER_DIR:=.
BUILD_SERVICE_NAME:=$(DOCKER_NAMESPACE)
DOCKER_BUILD_IMAGE_FILE:=$(DOCKER_DIR)/Dockerfile

TAGGING?=

ifeq ($(TAG),)
	echo "Please provide tag!"
else
	TAGGING:=$(DOCKER_REGISTRY)/$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(TAG)
endif

# Run Build Docker Image
DOCKER_BUILD_COMMAND:= \
    docker buildx build \
	--platform ${DOCKER_IMAGE_PLATFORM} \
    -f $(DOCKER_BUILD_IMAGE_FILE) \
	-t $(TAGGING) .

# Run Push Docker Image
DOCKER_BUILD_PUSH_COMMAND:= \
    docker buildx build \
	--platform ${DOCKER_IMAGE_PLATFORM} \
    -f $(DOCKER_BUILD_IMAGE_FILE) \
	-t $(TAGGING) --push .

##@ [Docker]

.PHONY: build
build: ## Docker build image with arguments VER="8.1" or with TAG=latest
	@$(DOCKER_BUILD_COMMAND)

.PHONY: build-push
build-push: ## Docker push image with arguments VER="8.1" or with TAG=latest
	@$(DOCKER_BUILD_PUSH_COMMAND)
