FROM golang:1.15-alpine as builder

RUN apk add --no-cache git build-base bash ca-certificates

RUN git clone --branch "main" --single-branch \
    https://github.com/micromdm/micromdm.git  /go/src/github.com/micromdm/micromdm && \
    cd /go/src/github.com/micromdm/micromdm && \
    git checkout v1.7.1 && \
    make


FROM alpine:3.12

RUN apk add --no-cache ca-certificates

COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/micromdm /
COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/mdmctl /
COPY run.sh /

CMD ["sh", "/run.sh"]
