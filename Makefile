#	building caddy Docker images outside of CI
#
include CADDY_COORDINATES
DOCKER_IMAGE_NAME=caddy
DOCKER_IMAGE_TAG=$(CADDY_VERSION)

build: Dockerfile CADDY_COORDINATES
	docker build --file Dockerfile --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

clean_build: Dockerfile CADDY_COORDINATES
	docker build --no-cache --pull --file Dockerfile --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

clean:
	/bin/rm -rf target
