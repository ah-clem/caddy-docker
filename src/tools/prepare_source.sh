#! /bin/bash

#	prepare_source -- fetch caddy release archive and prepare for compilation
#			  in a GOPATH like structure.
#

# fail early and often
set -eu
set -o pipefail

# define source
. CADDY_VERSION
. CADDY_SOURCE

# un-marshall source here
rm -rf target
mkdir -p target

# get caddy release archive
CADDY_RELEASE_ASSET_URL="https://${CADDY_BASE_URL}/archive/v${CADDY_VERSION}.zip"
CADDY_ARCHIVE="target/caddy-${CADDY_VERSION}.zip"
echo INFO: caddy release archive is \"${CADDY_RELEASE_ASSET_URL}\"
curl -L "${CADDY_RELEASE_ASSET_URL}" > "${CADDY_ARCHIVE}"

# extract caddy source
mkdir -p "target/src/${CADDY_PREFIX}"
unzip -q -d "target/src/${CADDY_PREFIX}" "${CADDY_ARCHIVE}"

# version label needs to be removed
echo INFO: caddy source in \"target/src/${CADDY_BASE_URL}\"
mv "target/src/${CADDY_PREFIX}/caddy-${CADDY_VERSION}" \
   "target/src/${CADDY_BASE_URL}"

# add other assets
cp src/resources/caddyfile target

