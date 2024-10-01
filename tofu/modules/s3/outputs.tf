output "s3_bucket_name" {
  value       = aws_s3_bucket.s3_bucket.bucket  # Outputs the actual bucket name.
  description = "Returns the name of the created S3 bucket"  
  
}
