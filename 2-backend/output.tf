output "invoke_url" {
    value = "${aws_apigatewayv2_stage.dev.invoke_url}/${split("/",aws_apigatewayv2_route.get_handler.route_key)[1]}"
}