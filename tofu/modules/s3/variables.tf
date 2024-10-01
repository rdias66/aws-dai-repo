variable "environment" {
  description = "The environment (e.g., production, development) where the S3 bucket is created."
  type        = string
}

variable "s3_bucket_name" {
  description = "The base name of the S3 bucket. This value will be combined with the environment variable to generate the full bucket name."
  type        = string
}
