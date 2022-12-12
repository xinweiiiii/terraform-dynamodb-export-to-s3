# ------------------------------------------------------------
# iam role for lambda execution
# ------------------------------------------------------------
data "template_file" "lambda_policy_alarm_role_json" {
  template = file("${path.module}/config/dynamodb-export-role.json")

  vars = {
    ACCOUNT_ID         = var.account_id
  }
}

resource "aws_iam_role" "dynamodb_export_role" {
  name                 = "dynamodb_export_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# Policy definition for the IAM role
resource "aws_iam_role_policy" "dynamodb_export_role_policy" {
  name   = "lambda-policy-alarm-role"
  role   = aws_iam_role.dynamodb_export_role.id
  policy = data.template_file.lambda_policy_alarm_role_json.rendered
}