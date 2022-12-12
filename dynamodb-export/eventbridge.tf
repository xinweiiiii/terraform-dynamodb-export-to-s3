# -------------------------------------------------------------------------
# Eventbridge to run the lambda
# --------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "frequency_of_exported_events" {
  name = "trigger-dynamodb-export"
  description = "export dynamodb data to s3"
  schedule_expression = "rate(1 hour)" // how often you want to trigger this export
}

resource "aws_cloudwatch_event_target" "iam_policy_scan_lambda_target" {
  arn = aws_lambda_function.export_lambda_function.arn
  rule = aws_cloudwatch_event_rule.frequency_of_exported_events.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.export_lambda_function.arn
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.frequency_of_exported_events.arn
}