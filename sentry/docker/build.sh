#!/bin/sh

set -e

export DOCKER_BUILDKIT=1
REGISTRY=docker.io/j3asolutions
SENTRY=$REGISTRY/sentry:21.3.0
SNUBA=$REGISTRY/snuba:21.3.0
CLICKHOUSE=$REGISTRY/clickhouse-server:20.8.15.11

docker build -f Dockerfile.sentry --tag "$SENTRY" .;

docker push $SENTRY;

docker build -f Dockerfile.snuba --tag "$SNUBA" .;

docker push $SNUBA;

docker build -f Dockerfile.clickhouse --tag "$CLICKHOUSE" .;

docker push $CLICKHOUSE;