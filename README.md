# terraform-dynamodb-export-to-s3
Terraform code to configure a lambda function to export DynamoDB table data to S3 on a recurring basis.

This terraform source code will provision a lambda function that is trigger by an event bridge on an hourly basis to export DynamoDB data to S3 on a recurring basis. To change the frequency you can update it via the `eventbridge.tf` file. 

## Architecture
![architecture](./images/DynamoDb%20to%20S3.png)

## Setup
1. Configure your AWS CLI to run terraform
2. Fill in the variables value in `dev.tfvars` 
3. Run `terraform apply -var-file=dev.tfvars`

## Conclusion
You can read up more on the implementation over here - 