# Open Telemetry (OTEL) Sample App


# Install

using golang 1.18+

Locally
```shell
go install fortio.org/otel-sample-app@latest
```

Or Docker - optimized for istio kubernetes cluster


# Testing:

Start a local jaeger with otel receiver:
```
docker run -p 16686:16686 -p 4317:4317 jaegertracing/all-in-one:latest --collector.otlp.enabled=true
```

```
fortio server & # echo/debug server
OTEL_SERVICE_NAME=local-test go run . -b3multi -listen :8000 -url http://localhost:8080/debug &
curl -v localhost:8000
```

Get traces: http://localhost:16686/search

See also [Makefile](Makefile) for examples.

The [Dockerfile](Dockerfile) is setup for istio/envoy 1.15.x config with `b3` multi headers (what istio envoy uses by default).

# Documentation

Initially loosely based on

https://github.com/open-telemetry/opentelemetry-go-contrib/tree/main/instrumentation/net/http/httptrace/otelhttptrace

and

https://github.com/open-telemetry/opentelemetry-go-contrib/blob/main/instrumentation/net/http/otelhttp/example/client/client.go

and

https://github.com/open-telemetry/opentelemetry-go-contrib/blob/main/instrumentation/net/http/otelhttp/example/server/server.go

all combined

(which doesn't work without an outer span setup first in the context, see [fortio/fortiotel/simple](https://github.com/fortio/fortiotel/blob/main/simple/otel_httptrace_simple.go))
