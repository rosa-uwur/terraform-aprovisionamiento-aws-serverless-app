resource "aws_dynamodb_table" "terraform-backend" {
  name           = "terraform-backend-${var.sandbox_id}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}