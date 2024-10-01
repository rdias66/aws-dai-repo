variable "repo_name" {
  description = "The name of the ECR repository. This will be used to identify the repository in AWS."
  type        = string
}

variable "platform" {
  description = "The platform/environment associated with the ECR repository (e.g., production, staging)."
  type        = string
}

variable "scan_on_push" {
  description = "Whether to enable image scanning on push to the ECR repository. Set to true to enable."
  type        = bool
}

variable "image_tag_mutability" {
  description = "Specifies whether image tags can be overwritten. Use 'MUTABLE' to allow overwriting, or 'IMMUTABLE' to prevent it."
  type        = string
}
