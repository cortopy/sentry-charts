#!/bin/sh

set -e

export DOCKER_BUILDKIT=1
REGISTRY=docker.io/j3asolutions
SENTRY_TAG=21.5.1
SENTRY=$REGISTRY/sentry:$SENTRY_TAG
SNUBA=$REGISTRY/snuba:$SENTRY_TAG
CLICKHOUSE_TAG=20.3.9.70
CLICKHOUSE=$REGISTRY/clickhouse-server:$CLICKHOUSE_TAG

docker build \
  -f Dockerfile.sentry \
  --build-arg SENTRY_TAG=$SENTRY_TAG \
  --tag "$SENTRY" .;

docker push $SENTRY;

docker build \
  -f Dockerfile.snuba \
  --build-arg SENTRY_TAG=$SENTRY_TAG \
  --tag "$SNUBA" .;

docker push $SNUBA;

docker build \
  -f Dockerfile.clickhouse \
  --build-arg CLICKHOUSE_TAG=$CLICKHOUSE_TAG \
  --tag "$CLICKHOUSE" .;

docker push $CLICKHOUSE;