variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "S3 bucket name for Terraform remote state"
  type        = string
  default     = "autonetops-tf-state-CHANGE_ME"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "force_destroy" {
  description = "Allow Terraform to destroy the bucket when running destroy"
  type        = bool
  default     = false
}
