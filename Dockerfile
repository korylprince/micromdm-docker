FROM golang:1.11-alpine as builder

RUN apk add --no-cache git build-base bash ca-certificates

RUN git clone --branch "master" --single-branch \
    https://github.com/micromdm/micromdm.git  /go/src/github.com/micromdm/micromdm && \
    cd /go/src/github.com/micromdm/micromdm && \
    git checkout 7d65dd88989d56e205d0b10625845d18edf53b41 && \
    make deps && make


FROM alpine:3.9

RUN apk add --no-cache ca-certificates

COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/micromdm /
COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/mdmctl /
COPY run.sh /

CMD ["sh", "/run.sh"]
