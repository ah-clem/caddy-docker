#! /bin/bash

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

# info
echo INFO: caddy version is \"${CADDY_VERSION}\"
echo INFO: caddy source in \"target/src/${CADDY_IMPORT_URL}\"

# as of version 1.*, caddy uses modules
#
export GO111MODULE=$(if [[ $CADDY_VERSION == 1.* ]] ; then echo on ; else echo off ; fi)

# compile caddy 
#
cd target
GOPATH="`pwd`" go install ${CADDY_IMPORT_URL}/caddy

