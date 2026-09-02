DOCKER := docker

IMAGE = $(file < docker/IMAGE)
TAG = $(IMAGE):$(file < VERSION)

REGISTRY = aatf

.PHONY: all build upload run test deploy

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

run: build
	$(DOCKER) run -p 60000:8080 -it --entrypoint /bin/bash $(TAG)

test: run

deploy:
	go run ./scripts/deploy.go
