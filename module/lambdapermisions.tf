resource "aws_lambda_permission" "api-gateway-invoke-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sayhello.function_name
  principal     = "apigateway.amazonaws.com"

  # any method on any resource
  source_arn = "${aws_api_gateway_rest_api.sayhello-api-gateway.execution_arn}/*/*"
}
