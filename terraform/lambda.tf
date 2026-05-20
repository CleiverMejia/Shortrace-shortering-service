resource "aws_lambda_function" "shorten" {
  function_name    = "${var.project_name}-shorten"
  role             = aws_iam_role.shorten_lambda.arn
  handler          = "handler.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.lambda_zip.output_path

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout    = 10
  memory_size = 128
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.short_urls.name
      BASE_URL = var.base_url
      ID_LENGTH = tostring(var.short_id_length)
    }
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_log_group" "shorten" {
  name              = "/aws/lambda/${aws_lambda_function.shorten.function_name}"
  retention_in_days = 14
  tags              = var.common_tags
}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.shorten.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.shorten.execution_arn}/*/*"
}
