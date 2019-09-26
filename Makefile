#	building caddy Docker images outside of CI and
#	misc. source/repo management
#
#	Notes:
#	1.  Docker image is tagged with the caddy version plus the version (git tag)
#	    of this build kit.  The published image is likely to have simpler tags
#	    as well.  The caddy version comes from the "CADDY_VERSION" file.  The
#	    source tag comes from the "TAG" file.  N.B. that we trust that the TAG
#	    file represents the git tag.  By using the TAG file, instead of querying
#	    a git repo, the image can be built from a release archive file: no git repo
#	    is needed.
#       2.  The TAG file is used in the git tag and release process.  The "tag" target
#           should only be run on the commited HEAD to be tagged.  A (TBD) CI build
#           pipeline will automate this semantic version bumping, tagging, and release
#           process.  For now, it is manual.

include CADDY_VERSION

DOCKER_IMAGE_NAME	:= caddy
DOCKER_IMAGE_TAG	:= $(CADDY_VERSION)
SOURCE_TAG		:= $(shell TAG)

build: Dockerfile CADDY_VERSION CADDY_SOURCE
	docker build --file Dockerfile \
	    --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)_$(SOURCE_TAG) .

clean_build: Dockerfile CADDY_VERSION CADDY_SOURCE
	docker build --no-cache --pull --file Dockerfile \
	    --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)_$(SOURCE_TAG) .

clean:
	/bin/rm -f go.mod go.sum
	-chmod -R +w target
	/bin/rm -rf target

#	tag last commit on this branch with info in "TAG" file
#	(best if TAG is commited prior to using it for a tag)
.PHONY: tag
tag:
	./TAG -v | git tag -F - `./TAG`
