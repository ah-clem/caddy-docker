#	building caddy Docker images outside of CI
#
include CADDY_VERSION
DOCKER_IMAGE_NAME=caddy
DOCKER_IMAGE_TAG=$(CADDY_VERSION)

build: Dockerfile CADDY_VERSION CADDY_SOURCE
	docker build --file Dockerfile --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

clean_build: Dockerfile CADDY_VERSION CADDY_SOURCE
	docker build --no-cache --pull --file Dockerfile --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

clean:
	/bin/rm -f go.mod go.sum
	-chmod -R +w target
	/bin/rm -rf target
