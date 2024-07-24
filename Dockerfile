FROM quay.io/projectquay/golang:1.22 AS builder
WORKDIR /go/src/app
ARG TARGETOS
ENV OS=${TARGETOS}
RUN echo "Building for OS: ${OS}"

COPY . .
RUN make ${OS}

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]