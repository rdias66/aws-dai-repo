# Resource block for the S3 bucket resource
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.environment}-${var.s3_bucket_name}"  # The bucket name is generated by combining the environment and the bucket name.

  tags = {
    Name        = var.s3_bucket_name      # The base name of the S3 bucket.
    Environment = var.environment         # The environment (e.g., production, development).
  }
}

# IAM policy to allow uploading files to the S3 bucket.
resource "aws_iam_policy" "file_upload_policy" {
  name        = "${var.environment}-${var.s3_bucket_name}-file-upload-policy"  # Policy name is dynamically generated using environment and bucket name.
  path        = "/"                                                            # IAM policy path.
  description = "Policy to allow file uploads to the S3 bucket"                

  # The actual policy JSON definition, allowing S3 PutObject action (upload) for the bucket.
  policy = jsonencode({
    Version   = "2012-10-17",  # Policy version 
    Statement = [
      {
        Action = [
          "s3:PutObject"  # Action allows uploading objects (files) to the bucket.
        ]
        Effect   = "Allow"  # Effect of the policy (Allow/deny).
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"  # Resource ARN specifies all objects inside the bucket.
      },
    ]
  })
}

# IAM policy to allow reading files from the S3 bucket.
resource "aws_iam_policy" "file_read_policy" {
  name        = "${var.environment}-${var.s3_bucket_name}-file-read-policy"  # Policy name is dynamically generated using environment and bucket name.
  path        = "/"                                                          # IAM policy path.
  description = "Policy to allow reading files from the S3 bucket"           

  # The actual policy JSON definition, allowing S3 GetObject action (read) for the bucket.
  policy = jsonencode({
    Version   = "2012-10-17",  # Policy version 
    Statement = [
      {
        Action = [
          "s3:GetObject"  # Action allows reading objects (files) from the bucket.
        ]
        Effect   = "Allow"  # Effect of the policy (Allow/deny).
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"  # Resource ARN specifies all objects inside the bucket.
      },
    ]
  })
}