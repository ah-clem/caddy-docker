# Docker image of a (vanilla) Caddy server

Downloads a [Caddy](https://caddyserver.com/) source archive for a given release, compiles it, and builds
a Docker image with the executable installed.

For now, there are no extra plug-ins or switches: just the compile of the release archive.  The
Caddy build scheme using "caddy/build.go" to inject version information in the binary is not
used (might not even work: needs to build from a git repo?).

## Source Organization

The top level contains the Dockerfile driving the download/compile/build process.  A Makefile
captures basic steps of build, test, clean. It documents the exact shell commands used.

The precise source release to be downloaded and built is defined in "CADDY_COORDINATES".

See "Testing" below for understanding of the "ci" directory.

The "src" directory contains tool scripts as well as resources that are included in the image.
Note that the Caddy source *is not* included here: it is downloaded from github (or somewhere else).

## Dependencies

You need Docker installed and a Docker daemon running if you want to build an image.

If you are going to download and compile Caddy outside of Docker (see "Building" below), then you need Go installed.

## Building

`make` defaults to downloading and compiling Caddy in a Docker container, then installs the generated
binary in a (smaller) image.

It is possible to download and compile Caddy outside of Docker and without building an image: just
run the following:

- `./src/tools/prepare_source.sh`
- `./src/tools/compile.sh`

These are the same scripts, run in the same context, that are used in the Docker build.  So, you can do
some quick testing without launching a Docker build.  This is a key design aspect: This
repo should work identically inside or outside of a container, including tests.  Setting up the
surrounding context and dependencies should be kept to a minimum.

## Testing

TBD

The `ci` directory will contain continous integration pipeline using concourse.ci.

## Running

TBD

Try: `docker run --rm -p 80:2015/tcp caddy:0.11.2`

and get the default Caddy server running on your localhost, port 80.

## Credits

Inspiration and a bit of code snatched from [docker-caddy](https://github.com/jumanjihouse/docker-caddy). Thanks!

But, I wanted something a bit different, so I started (yet another) Docker/Caddy project:

- wanted to continue exploring concourse.ci
- did not want to build from a repo
- wanted a vanilla server
