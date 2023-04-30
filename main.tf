# Supports the use of randomness within Terraform configurations. 
resource "random_id" "this" {
  byte_length = 3
}

# Terraform module which creates AWS KMS resources.
module "kms" {

  source  = "evners/kms/aws"
  version = "~> 1.0"

  resource = local.bucket_name

}

# Provides a S3 bucket resource.
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "this" {

  bucket = local.bucket_name

  tags = {
    Name      = local.bucket_name
    Terraform = "true"
    Resource  = "s3-bucket",
  }

}

# Provides a S3 bucket server-side encryption configuration resource.
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {

  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = module.kms.key_id
      sse_algorithm     = "aws:kms"
    }
  }

}

# Provides an S3 bucket ACL resource.
resource "aws_s3_bucket_acl" "this" {

  acl        = "private"
  bucket     = aws_s3_bucket.this.id
  depends_on = [aws_s3_bucket_ownership_controls.this]

}

# Provides a resource to manage S3 Bucket Ownership Controls. For more information, 
# see: https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html
resource "aws_s3_bucket_ownership_controls" "this" {

  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "ObjectWriter"
  }

}

# Provides a resource for controlling versioning on an S3 bucket. For more information, 
# see: https://docs.aws.amazon.com/AmazonS3/latest/userguide/manage-versioning-examples.html
resource "aws_s3_bucket_versioning" "this" {

  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }

}

# Manages S3 bucket-level Public Access Block configuration. For more information, 
# see: https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html
resource "aws_s3_bucket_public_access_block" "this" {

  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}


