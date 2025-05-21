#!/bin/bash

REGION="sa-east-1"
REPOSITORIES=("repo_name1" "repo_name2") # nomes gerados pro respectivos repos

LOG_DIR="./cleaner-logs"
LOG_FILE="$LOG_DIR/clean-ecr-$(date +'%Y-%m-%d_%H-%M-%S').log"

mkdir -p "$LOG_DIR"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

for REPO_NAME in "${REPOSITORIES[@]}"; do
  log "Limpando o repositório: $REPO_NAME"

  IMAGES=$(aws ecr describe-images \
    --region $REGION \
    --repository-name $REPO_NAME \
    --query 'imageDetails | sort_by(@, &imagePushedAt) | reverse(@) | [].[imageTag, imageDigest]' \
    --output json)

  LATEST_IMAGE=$(echo "$IMAGES" | jq -r '.[] | select(.[0] == "latest")')
  SECOND_LATEST_IMAGE=$(echo "$IMAGES" | jq -r '.[] | select(.[0] != "latest") | .[0]' | head -n 1)

  log "Última imagem (latest): $LATEST_IMAGE"
  log "Penúltima imagem: $SECOND_LATEST_IMAGE"
  #so deixa a imagem mais recente
  for image in $(echo "$IMAGES" | jq -r '.[] | select(.[0] != "latest") | .[0]'); do
    if [ "$image" != "$SECOND_LATEST_IMAGE" ]; then
      IMAGE_DIGEST=$(echo "$IMAGES" | jq -r ".[] | select(.[0] == \"$image\") | .[1]")

      log "Removendo imagem com a tag $image (digest: $IMAGE_DIGEST) no repositório $REPO_NAME..."
      DELETE_OUTPUT=$(aws ecr batch-delete-image \
        --region $REGION \
        --repository-name $REPO_NAME \
        --image-ids imageDigest=$IMAGE_DIGEST 2>&1)
      
      if [ $? -eq 0 ]; then
        log "Imagem com a tag $image removida com sucesso do repositório $REPO_NAME"
      else
        log "Falha ao remover a imagem com a tag $image no repositório $REPO_NAME"
        log "Error: $DELETE_OUTPUT"
      fi
    else
      log "Mantendo a imagem com a tag $image (penúltima ou 'latest') no repositório $REPO_NAME"
    fi
  done

  log "Limpeza completa para o repositório: $REPO_NAME"
done

log "Limpeza do ECR completa, logs registrados em: $LOG_FILE"
