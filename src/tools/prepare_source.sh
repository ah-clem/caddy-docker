#	prepare_source -- fetch caddy release archive and prepare for compilation
#

# fail early and often
set -eu
set -o pipefail

# define source
. CADDY_COORDINATES

# marshall source here
rm -rf target
mkdir -p target

# get caddy release archive
CADDY_RELEASE_ASSET_URL="https://${CADDY_IMPORT_URL}/archive/v${CADDY_VERSION}.zip"
CADDY_ARCHIVE="target/caddy-${CADDY_VERSION}.zip"
curl -L "${CADDY_RELEASE_ASSET_URL}" > "${CADDY_ARCHIVE}"

# extract caddy source
mkdir -p "target/src/${CADDY_IMPORT_PREFIX}"
unzip -q -d "target/src/${CADDY_IMPORT_PREFIX}" "${CADDY_ARCHIVE}"

# version label needs to be removed
mv "target/src/${CADDY_IMPORT_PREFIX}/caddy-${CADDY_VERSION}" \
   "target/src/${CADDY_IMPORT_URL}"

# add other assets
cp src/resources/caddyfile target

