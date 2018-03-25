IMAGE_NAME = roquie/heroku-like-docker-php
VERSION = latest

BUILD_DATE = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_REF = $(shell git rev-parse --short HEAD)


build:
	docker build \
      --build-arg VERSION=$(VERSION) \
      --build-arg BUILD_DATE=$(BUILD_DATE) \
      --build-arg VCS_REF=$(VCS_REF) \
      -t $(IMAGE_NAME):$(VERSION) .

push:
	docker push $(IMAGE_NAME):$(VERSION)

all: build push
