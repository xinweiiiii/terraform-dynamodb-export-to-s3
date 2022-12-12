variable "account_id" {
    type = string
    description = "The ID that belongs to the account"
}

variable "bucket_name" {
    type = string
    description = "S3 bucket name to store the exported files"
}

variable "table_arn" {
    type = string
    description = "Dynamodb table arn"
}

