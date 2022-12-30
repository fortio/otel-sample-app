
TAG:=$(shell git describe --tags --match 'v*' --always)

docker-push:
	docker buildx build . -f Dockerfile.local --build-arg VERSION=$(TAG) --platform linux/amd64,linux/arm64 --tag fortio/in-out-sample:$(TAG)  --tag fortio/in-out-sample:latest --push

docker-buildx-setup:
	docker context create build
	docker buildx create --use build

local-jaeger:
	docker run -p 16686:16686 -p 4317:4317 jaegertracing/all-in-one:latest --collector.otlp.enabled=true &

local-test:
	@echo "Assuming you have a local fortio server running - then curl localhost:8000 and check traces in jaeger"
	OTEL_SERVICE_NAME=local-test go run . -b3multi -listen :8000 -url http://localhost:8080/debug
