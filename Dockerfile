#	fetch caddy source, build it, then build a caddy image
#
FROM golang:1.11.5-alpine3.8 as builder

ENV CGO_ENABLED 0
ENV GOOS linux

RUN apk add curl

#	set up builder and copy in build context (the caddy-docker repo)
#
RUN adduser -D builder
USER builder
WORKDIR /home/builder
COPY . /home/builder/

#	fetch and prepare caddy source
#
RUN ./src/tools/prepare_source.sh

#	compile caddy
#
RUN ./src/tools/compile.sh

#	now, put caddy executable in runtime image
#
FROM alpine:3.8

RUN adduser -Du 1000 caddy

#	set up defaults so image runs w/o anything else provided
#
ENV CASE_SENSITIVE_PATH=true
RUN echo "hello world" > /home/caddy/index.html
RUN mkdir -p /etc/caddy
COPY --from=builder /home/builder/target/caddyfile /etc/caddy/caddyfile

#	dedicate well known content directory to caddy
#
RUN \
    mkdir -p /var/www && \
    chown caddy:caddy /var/www && \
    :

#	install the caddy binary that we built above
#
COPY --from=builder /home/builder/target/bin/caddy /usr/sbin/caddy

#	run as an unprivileged user
#	CMD is overridden on command line with caddy args (serve something besides default)
#
USER caddy
ENTRYPOINT ["/usr/sbin/caddy"]
CMD ["-conf", "/etc/caddy/caddyfile"]

