#!/usr/bin/env bash
set -euo pipefail

# Restart app and example services in one command.
# Usage:
#   ./restart-all.sh          # safe restart (keeps volumes)
#   ./restart-all.sh --purge  # destructive restart (removes volumes)

if [[ "${1-}" == "--purge" ]]; then
  echo "Stopping and removing containers, networks, and volumes..."
  docker compose -f docker-compose.yml -f docker-compose.services.yml down -v --remove-orphans
else
  echo "Stopping and removing containers (volumes preserved)..."
  docker compose -f docker-compose.yml -f docker-compose.services.yml down --remove-orphans
fi

echo "Building and starting containers..."
docker compose -f docker-compose.yml -f docker-compose.services.yml up -d --build

echo "Done."
