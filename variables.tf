variable "region" {
  description = "The AWS default region where you want to create resources."
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "Name for S3 bucket."
  type        = string
  default     = "s3-bucket"
}
