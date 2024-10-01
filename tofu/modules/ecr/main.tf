# Resource block for Amazon ECR (Elastic Container Registry) repository module
resource "aws_ecr_repository" "ecr" {
  # The name of the ECR repository, passed as a variable.
  name                 = var.repo_name
  
  # Specifies the mutability of image tags, using the variable defined for it.
  image_tag_mutability = var.image_tag_mutability

  # Configures image scanning on push to the repository, using the variable defined for it.
  image_scanning_configuration {
    scan_on_push = var.scan_on_push  # Enables or disables automatic scanning of images when they are pushed to the repository.
  }

  # Tags for organizational and cost-tracking purposes.
  tags = {
    Name     = var.repo_name  # Sets the Name tag to the repository name.
    Platform = var.platform    # Sets the Platform tag, indicating the environment (e.g., production, staging).
    Type     = "Service"      # Indicates that this resource is a service.
  }
}

# Resource block for the policy for the ECR repository.
resource "aws_ecr_repository_policy" "ecr_policy" {
  # Specifies the repository to which this policy will apply.
  repository = aws_ecr_repository.ecr.name

  # The policy governing access to the repository in JSON format
  # This is the info policy that will be applied and used to manage the access in this ECR instance for the AWS's accounts IAM users
  policy = jsonencode({
    Version : "2008-10-17",  # Specifies the version of the policy language.
    Statement : [
      {
        Sid : "ECR Repository policy",  # Statement ID for identifying the policy.
        Effect : "Allow",               # Allows the actions specified in this policy.
        Principal : "*",                # Applies to all principals (users and services).
        Action : [
          # List of actions permitted on the ECR repository.
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
      }
    ]
  })
}
