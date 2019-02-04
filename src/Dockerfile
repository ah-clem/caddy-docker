#	build caddy, then build a caddy image
#
FROM golang:1.11.5-alpine3.8 as builder

ENV CGO_ENABLED 0
ENV GOOS linux

#	build context should include a go "src" directory (e.g. src/github.com/mholt/caddy/)
COPY src ${GOPATH}/src

#	compile caddy.
RUN go install github.com/mholt/caddy/caddy

#	now, put caddy executable in runtime image
#
FROM alpine:3.8

ENV CASE_SENSITIVE_PATH=true

RUN adduser -Du 1000 caddy

RUN echo "hello world" > /home/caddy/index.html
RUN mkdir -p /etc/caddy
COPY caddyfile /etc/caddy/caddyfile

RUN \
    mkdir -p /var/www && \
    chown caddy:caddy /var/www && \
    :

COPY --from=builder /go/bin/caddy /usr/sbin/caddy

#	Run as an unprivileged user.

USER caddy
ENTRYPOINT ["/usr/sbin/caddy"]
CMD ["-conf", "/etc/caddy/caddyfile"]

