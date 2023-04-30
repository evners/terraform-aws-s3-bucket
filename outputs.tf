output "bucket_name" {
  description = "The S3 bucket name."
  value       = aws_s3_bucket.this.id
}

output "kms_key_alias" {
  description = "The KMS key alias used for bucket encryption."
  value       = module.kms.key_alias
}
