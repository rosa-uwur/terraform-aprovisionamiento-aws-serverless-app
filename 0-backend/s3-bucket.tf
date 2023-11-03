resource "random_id" "bucket_id" {
  byte_length = 1
}
resource "aws_s3_bucket" "terraform-backend" {
  bucket = "teraform-backend-${var.sandbox_id}-${random_id.bucket_id.dec}"
  tags = {
    Name = "teraform-backend-${var.sandbox_id}-${random_id.bucket_id.dec}"
  }
}

resource "aws_kms_key" "terraform-backend-key" {
  description             = "Key used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-backend-encryption" {
  bucket = aws_s3_bucket.terraform-backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform-backend-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}