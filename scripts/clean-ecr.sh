#!/bin/bash

REGION="sa-east-1"
REPOSITORIES=("repo_name1" "repo_name2") # Change to the names of your repos(or repo) created in the tofu production module(the name on tfvars)

LOG_DIR="./cleaner-logs"
LOG_FILE="$LOG_DIR/clean-ecr-$(date +'%Y-%m-%d_%H-%M-%S').log"

mkdir -p "$LOG_DIR"

log() {
  echo "$1" | tee -a "$LOG_FILE"
}

for REPO_NAME in "${REPOSITORIES[@]}"; do
  log "Cleaning up container repository: $REPO_NAME"

  IMAGES_TO_DELETE=$(aws ecr list-images \
    --region $REGION \
    --repository-name $REPO_NAME \
    --query 'imageIds[?(@.imageTag != `latest`)]' \
    --output json | jq -r '.[] | @base64')

  # Check if any images were found
  if [ -z "$IMAGES_TO_DELETE" ]; then
    log "No images to delete in repository: $REPO_NAME (only 'latest' tag found or no images at all)"
    continue
  else
    log "Images found for deletion in $REPO_NAME:"
  fi

  # Delete images one by one
  for image in $IMAGES_TO_DELETE; do
    IMAGE_DIGEST=$(echo "$image" | base64 --decode | jq -r '.imageDigest')
    IMAGE_TAG=$(echo "$image" | base64 --decode | jq -r '.imageTag')

    log "Found image with tag ${IMAGE_TAG:-null} (digest: $IMAGE_DIGEST) in repository $REPO_NAME"

    if [ -n "$IMAGE_DIGEST" ] && [ "$IMAGE_TAG" != "latest" ]; then
      log "Deleting image with tag ${IMAGE_TAG:-null} (digest: $IMAGE_DIGEST) in repository $REPO_NAME..."
      DELETE_OUTPUT=$(aws ecr batch-delete-image \
        --region $REGION \
        --repository-name $REPO_NAME \
        --image-ids imageDigest=$IMAGE_DIGEST 2>&1)
      
      if [ $? -eq 0 ]; then
        log "Successfully deleted image with tag ${IMAGE_TAG:-null} in repository $REPO_NAME"
      else
        log "Failed to delete image with tag ${IMAGE_TAG:-null} in repository $REPO_NAME"
        log "Error: $DELETE_OUTPUT"
      fi
    else
      log "Skipping image with tag ${IMAGE_TAG:-null} in repository $REPO_NAME (either 'latest' or no valid digest)"
    fi
  done

  log "Cleanup completed for container repository: $REPO_NAME"
done

log "ECR cleanup script completed. Logs saved in $LOG_FILE"
