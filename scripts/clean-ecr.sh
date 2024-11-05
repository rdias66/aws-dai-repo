#!/bin/bash


REGION="sa-east-1" #Your region, same as the one set in the tfvars file


REPOSITORIES=("repo_name" "repo_name")  #Your repo names(configured in the ecr module, probably in your tfvars file)


for REPO_NAME in "${REPOSITORIES[@]}"; do
  echo "Cleaning up container repository: $REPO_NAME"


  IMAGES_TO_DELETE=$(aws ecr list-images \
    --region $REGION \
    --repository-name $REPO_NAME \
    --filter "tagStatus=TAGGED" \
    --query 'imageIds[?(@.imageTag != `latest`)]' \
    --output json | \
    jq -r '.[] | @base64') 

  
  for image in $IMAGES_TO_DELETE; do
    
    IMAGE_DIGEST=$(echo "$image" | base64 --decode | jq -r '.imageDigest')
    IMAGE_TAG=$(echo "$image" | base64 --decode | jq -r '.imageTag')
    
    echo "Deleting image with tag $IMAGE_TAG (digest: $IMAGE_DIGEST) in repository $REPO_NAME..."

    aws ecr batch-delete-image \
      --region $REGION \
      --repository-name $REPO_NAME \
      --image-ids imageDigest=$IMAGE_DIGEST
  done

  echo "Cleanup completed for container repository: $REPO_NAME"
done
