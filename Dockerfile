FROM golang:1.15-alpine as builder
RUN apk --no-cache add make git
WORKDIR /
COPY . /
RUN make build

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /bin/kubeval .
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN ln -s /kubeval /usr/local/bin/kubeval
ENTRYPOINT ["/entrypoint.sh"]
