DOCKER := docker

IMAGE = $(file < docker/IMAGE)
TAG = $(IMAGE):$(file < VERSION)

REGISTRY = aatf
PLATFORM ?= linux/amd64
ARCH ?= amd64

.PHONY: all build upload upload-arch manifest run test deploy

all: build upload

build:
	$(DOCKER) build --file docker/Dockerfile --tag $(TAG) .

upload:
	$(DOCKER) buildx build \
		--file docker/Dockerfile \
		--no-cache \
		--platform linux/arm64,linux/amd64 \
		--push \
		--tag $(REGISTRY)/$(TAG) \
		--tag $(REGISTRY)/$(IMAGE):latest .

upload-arch:
	$(DOCKER) buildx build \
		--file docker/Dockerfile \
		--no-cache \
		--platform $(PLATFORM) \
		--push \
		--tag $(REGISTRY)/$(TAG)-$(ARCH) \
		--tag $(REGISTRY)/$(IMAGE):latest-$(ARCH) .

manifest:
	$(DOCKER) buildx imagetools create \
		--tag $(REGISTRY)/$(TAG) \
		--tag $(REGISTRY)/$(IMAGE):latest \
		$(REGISTRY)/$(TAG)-amd64 \
		$(REGISTRY)/$(TAG)-arm64
	$(DOCKER) buildx imagetools inspect $(REGISTRY)/$(TAG)

run: build
	$(DOCKER) run -p 60000:8080 -it --entrypoint /bin/bash $(TAG)

test:
	$(DOCKER) run --rm --network host -e RAILS_ENV=test --entrypoint bundle -v "$$(pwd)/src:/rails" -v "$$(pwd)/VERSION:/VERSION:ro" -w /rails $(TAG) exec rake

deploy:
	go run ./scripts/deploy.go
