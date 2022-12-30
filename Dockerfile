# Go releaser dockerfile
#FROM alpine as certs
#RUN apk update && apk add ca-certificates
# ^ alpine doesn't seem to work (with goreleaser, works fine from docker build cmd line), trying with ubuntu
FROM ubuntu as certs
RUN apt-get update && apt-get install -y ca-certificates
FROM scratch
COPY otel-sample-app /usr/local/bin/otel-sample-app
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
EXPOSE 8080
ENV OTEL_SERVICE_NAME "in-out-sample"
# Assumes you added --collector.otlp.enabled=true to your Jaeger deployment
ENV OTEL_EXPORTER_OTLP_ENDPOINT http://jaeger-collector.istio-system.svc.cluster.local:4317
CMD ["/usr/local/bin/otel-sample-app", "-b3multi"]
