# Go releaser dockerfile
FROM alpine as alpine
RUN apk update && apk add ca-certificates
FROM scratch
COPY otel-sample-app /usr/local/bin/otel-sample-app
COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
EXPOSE 8080
ENV OTEL_SERVICE_NAME "in-out-sample"
# Assumes you added --collector.otlp.enabled=true to your Jaeger deployment
ENV OTEL_EXPORTER_OTLP_ENDPOINT http://jaeger-collector.istio-system.svc.cluster.local:4317
CMD ["/usr/local/bin/otel-sample-app", "-b3"]
