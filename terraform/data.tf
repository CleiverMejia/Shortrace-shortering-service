data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file  = "${path.module}/../app/dist/handler.js"
  output_path = "${path.module}/.build/shorten.zip"
}