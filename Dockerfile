FROM golang:1.17-alpine as builder

ARG VERSION

RUN apk add --no-cache git build-base bash ca-certificates

RUN git clone --branch "main" --single-branch \
    https://github.com/micromdm/micromdm.git  /go/src/github.com/micromdm/micromdm && \
    cd /go/src/github.com/micromdm/micromdm && \
    git checkout "$VERSION" && \
    make


FROM alpine:3.15

RUN apk add --no-cache ca-certificates

COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/micromdm /
COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/mdmctl /
COPY run.sh /

CMD ["sh", "/run.sh"]
