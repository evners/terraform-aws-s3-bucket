locals {
  bucket_name = "${var.bucket_name}-${random_id.this.dec}"
}
