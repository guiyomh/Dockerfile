FROM golang:alpine AS buildenv
WORKDIR /go/src/github.com/immortal
RUN apk --no-cache add git make \
    && git clone https://github.com/immortal/immortal.git /go/src/github.com/immortal/immortal \
    && cd /go/src/github.com/immortal/immortal \
    && make

FROM aelsabbahy/goss:latest AS goss

FROM alpine
MAINTAINER Guillaume CAMUS <guillaume.camus@gmail.fr>
ARG GIT_COMMIT=unkown
LABEL maintainer=guillaume.camus@gmail.fr \
    vendor=guiyomh \
    description="A *nix cross-platform (OS agnostic) supervisor"  \
    repository=https://github.com/guiyomh/Dockerfile.git \
    reference=https://github.com/guiyomh/Dockerfile/docker/immortal/latest
COPY --from=goss /goss /goss
COPY tests/ /goss
COPY --from=buildenv /go/src/github.com/immortal/immortal/immort* /usr/local/bin/
COPY --from=buildenv /go/src/github.com/immortal/immortal/man/*.8 /usr/local/share/man/man8/
HEALTHCHECK --interval=60s --timeout=5s \
    CMD /goss/goss -g /goss/goss.yaml validate
