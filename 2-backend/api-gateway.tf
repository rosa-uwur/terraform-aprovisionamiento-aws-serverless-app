resource "aws_apigatewayv2_api" "http-api-gateway" {
  name          = "backend-api-${var.sandbox_id}"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["POST", "GET", "OPTIONS"]
    allow_headers = ["*"]
    max_age = 300
  }
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.http-api-gateway.id
  name        = "dev"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda-handler" {
  api_id = aws_apigatewayv2_api.http-api-gateway.id

  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.backend-lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "get_handler" {
  api_id    = aws_apigatewayv2_api.http-api-gateway.id
  route_key = "GET /movies"

  target = "integrations/${aws_apigatewayv2_integration.lambda-handler.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.http-api-gateway.execution_arn}/*/*"
}