resource "aws_s3_object" "script" {
  key          = "scripts.js"
  bucket       = aws_s3_bucket.static-website.id
  content      = replace(file("${path.module}/assets/scripts.js"), "BACKEND_URL", var.backend_endpoint)
  content_type = "text/plain"
  acl          = "public-read"
  depends_on = [aws_s3_bucket_acl.static-website]
}
resource "aws_s3_object" "static-files" {
  for_each = {
    logo = {
      file = "assets/logo_b.png",
      type = "image/png"
    },
    style = {
      file = "assets/style.css",
      type = "text/css"
    }

    index = {
      file = "assets/index.html",
      type = "text/html"
    }
  }
  key          = "${split("/", each.value.file)[1]}"
  bucket       = aws_s3_bucket.static-website.id
  source       = "${path.module}/${each.value.file}"
  content_type = each.value.type
  acl          = "public-read"
  depends_on = [aws_s3_bucket_acl.static-website]
}
