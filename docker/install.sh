#!/usr/bin/env bash
#
# Docker
#
# Links docker-compose as a Docker CLI plugin so `docker compose` works.

DOCKER_CLI_PLUGINS_DIR="$HOME/.docker/cli-plugins"

mkdir -p "$DOCKER_CLI_PLUGINS_DIR"

COMPOSE_BIN="$(brew --prefix)/opt/docker-compose/bin/docker-compose"

if [ -f "$COMPOSE_BIN" ]; then
  ln -sf "$COMPOSE_BIN" "$DOCKER_CLI_PLUGINS_DIR/docker-compose"
  echo "  linked docker-compose CLI plugin"
else
  echo "  docker-compose not found — install via Brewfile first"
fi
