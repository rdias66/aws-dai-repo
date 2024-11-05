#!/bin/bash

LOG_DIR="./cleaner-logs"
LOG_FILE="$LOG_DIR/clean-docker-$(date +'%Y-%m-%d_%H-%M-%S').log"

mkdir -p "$LOG_DIR"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

log "Starting Docker cleanup script..."

log "Cleaning up stopped Docker containers..."
CONTAINER_PRUNE_OUTPUT=$(docker container prune -f 2>&1)
log "$CONTAINER_PRUNE_OUTPUT"

log "Cleaning up unused Docker images..."
IMAGE_PRUNE_OUTPUT=$(docker image prune -a -f 2>&1)
log "$IMAGE_PRUNE_OUTPUT"

log "Docker cleanup script finished."
