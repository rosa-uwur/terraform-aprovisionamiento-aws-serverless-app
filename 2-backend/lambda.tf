data "aws_iam_policy_document" "assume-role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam-for-lambda" {
  name               = "iam-for-lambda-${var.sandbox_id}"
  assume_role_policy = data.aws_iam_policy_document.assume-role.json
}

resource "aws_iam_policy" "dynamodb-policy" {
  name        = "dynamoDB-fullAccess-${var.sandbox_id}"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_dynamodb_policy" {
  role       = aws_iam_role.iam-for-lambda.name
  policy_arn = aws_iam_policy.dynamodb-policy.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.js"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "backend-lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = "movies-backend-${var.sandbox_id}"
  role          = aws_iam_role.iam-for-lambda.arn
  
  source_code_hash = data.archive_file.lambda.output_base64sha256
  handler       = "index.handler"
  runtime = "nodejs14.x"

  environment {
    variables = {
      TABLE_NAME = "${var.table_name_prefix}-${var.sandbox_id}"
    }
  }
}