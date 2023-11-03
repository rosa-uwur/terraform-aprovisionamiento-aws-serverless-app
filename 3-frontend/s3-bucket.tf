resource "random_id" "bucket_id" {
  byte_length = 1
}
resource "aws_s3_bucket" "static-website" {
  bucket = "static-website-${var.sandbox_id}-${random_id.bucket_id.dec}"
  tags = {
    Name = "static-website"
  }
}

resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  index_document {
    suffix = "index.html"
  }
}

# S3 bucket ACL access

resource "aws_s3_bucket_ownership_controls" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static-website" {
  bucket = aws_s3_bucket.static-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static-website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static-website,
    aws_s3_bucket_public_access_block.static-website,
  ]

  bucket = aws_s3_bucket.static-website.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "static-website" {
  bucket = aws_s3_bucket.static-website.id
  policy = data.aws_iam_policy_document.static-website.json
}

data "aws_iam_policy_document" "static-website" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.static-website.arn,
      "${aws_s3_bucket.static-website.arn}/*",
    ]
  }
}