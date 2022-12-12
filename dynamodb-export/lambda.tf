data "archive_file" "export_lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda-code/index.js"
  output_path = "${path.module}/lambda-code/archive.zip"
}

resource "aws_lambda_function" "export_lambda_function" {
  filename      = "${path.module}/lambda-code/archive.zip"
  function_name = "export-dynamodb-s3"
  role          = aws_iam_role.dynamodb_export_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  timeout       = 360
  memory_size   = 2048

  source_code_hash = data.archive_file.export_lambda.output_base64sha256

  environment {
    variables = {
      ACCOUNT_ID = var.account_id
      BUCKET_NAME = var.bucket_name
      TABLE_ARN = var.table_arn
    }
  }

  tracing_config {
    mode = "Active"
  }
}