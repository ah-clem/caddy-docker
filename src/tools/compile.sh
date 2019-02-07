#	compile -- compile caddy source
#
#		It is assumed that the caddy source has been unpacked
#		into "target/src". Caddy executable ends up as "target/bin/caddy" 

# fail early and often
#
set -eu
set -o pipefail

# define the "coordinates" of the source
#
. CADDY_COORDINATES

# compile caddy 
#
cd target
GOPATH="`pwd`" go install ${CADDY_IMPORT_URL}/caddy

