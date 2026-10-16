output "s3_state_bucket" {
  description = "Name of the S3 bucket storing Terraform state"
  value       = aws_s3_bucket.state.id
}
