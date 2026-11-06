output "s3_state_bucket" {
  description = "Name of the S3 bucket storing Terraform state"
  value       = aws_s3_bucket.state.id
}

output "bucket_region" {
  description = "AWS region of the state bucket"
  value       = aws_s3_bucket.state.region
}
