module "dynamodb-export-s3" {
    source = "./dynamodb-export"
    account_id = var.account_id
    bucket_name = var.bucket_name
    table_arn = var.table_arn
}