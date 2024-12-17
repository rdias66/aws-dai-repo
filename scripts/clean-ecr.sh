#!/bin/bash

REGION="sa-east-1"
REPOSITORIES=("repo_name1" "repo_name2") # Mude para os nomes dos repositórios criados no seu modulo de production

LOG_DIR="./cleaner-logs"
LOG_FILE="$LOG_DIR/clean-ecr-$(date +'%Y-%m-%d_%H-%M-%S').log"

mkdir -p "$LOG_DIR"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

for REPO_NAME in "${REPOSITORIES[@]}"; do
  log "Limpando o repositório: $REPO_NAME"

  IMAGES_TO_DELETE=$(aws ecr list-images \
    --region $REGION \
    --repository-name $REPO_NAME \
    --query 'imageIds[?(@.imageTag != `latest`)]' \
    --output json | jq -r '.[] | @base64')


  if [ -z "$IMAGES_TO_DELETE" ]; then
    log "Nenhuma imagem para remover no repositório: $REPO_NAME (apenas tag 'latest' ou nenhuma imagem)"
    continue
  else
    log "Imagens encontradas para remoção no repositório $REPO_NAME:"
  fi

  # Delete images one by one
  for image in $IMAGES_TO_DELETE; do
    IMAGE_DIGEST=$(echo "$image" | base64 --decode | jq -r '.imageDigest')
    IMAGE_TAG=$(echo "$image" | base64 --decode | jq -r '.imageTag')

    log "Imagem encontrada com a ${IMAGE_TAG:-null} (digest: $IMAGE_DIGEST) no repositorio $REPO_NAME"

    if [ -n "$IMAGE_DIGEST" ] && [ "$IMAGE_TAG" != "latest" ]; then
      log "Removendo imagem com a tag ${IMAGE_TAG:-null} (digest: $IMAGE_DIGEST) no repositorio $REPO_NAME..."
      DELETE_OUTPUT=$(aws ecr batch-delete-image \
        --region $REGION \
        --repository-name $REPO_NAME \
        --image-ids imageDigest=$IMAGE_DIGEST 2>&1)
      
      if [ $? -eq 0 ]; then
        log "Imagem com a tag ${IMAGE_TAG:-null} removida com sucesso do repositorio $REPO_NAME"
      else
        log "Falha ao removar a imagem com a tag ${IMAGE_TAG:-null} no repositorio $REPO_NAME"
        log "Error: $DELETE_OUTPUT"
      fi
    else
      log "Pulando a imagem com a tag ${IMAGE_TAG:-null} no repositorio $REPO_NAME ('latest' ou inválido)"
    fi
  done

  log "Limpeza completa para o repositório: $REPO_NAME"
done

log "Limpeza do ecr completa , logs registrados em : $LOG_FILE"
