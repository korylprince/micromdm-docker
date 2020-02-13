FROM golang:1.13-alpine as builder

RUN apk add --no-cache git build-base bash ca-certificates

RUN git clone --branch "master" --single-branch \
    https://github.com/micromdm/micromdm.git  /go/src/github.com/micromdm/micromdm && \
    cd /go/src/github.com/micromdm/micromdm && \
    git checkout ea5c0a3865e87f5de04a58dc2c67b5fa6f6fd7de && \
    make


FROM alpine:3.11

RUN apk add --no-cache ca-certificates

COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/micromdm /
COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/mdmctl /
COPY run.sh /

CMD ["sh", "/run.sh"]
