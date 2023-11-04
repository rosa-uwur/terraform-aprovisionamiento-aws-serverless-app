output "name" {
  value = "https://${aws_s3_bucket.static-website.bucket_domain_name}/index.html"
}