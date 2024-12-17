#!/bin/bash

LOG_DIR="./cleaner-logs"
LOG_FILE="$LOG_DIR/clean-docker-$(date +'%Y-%m-%d_%H-%M-%S').log"

mkdir -p "$LOG_DIR"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

log "Iniciando limpeza Docker..."

log "Limpando containers Docker nao usados ou parados..."
CONTAINER_PRUNE_OUTPUT=$(docker container prune -f 2>&1)
log "$CONTAINER_PRUNE_OUTPUT"

log "Limpando imagens Docker nao usadas..."
IMAGE_PRUNE_OUTPUT=$(docker image prune -a -f 2>&1)
log "$IMAGE_PRUNE_OUTPUT"

log "Limpeza do dDocker finalizada"
