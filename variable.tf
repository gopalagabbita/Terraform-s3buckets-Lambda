variable "iam_role_name" {
  type    = string
  default = "ggabbita-test-list-buckets-role"
}

variable "lambda_name" {
  type    = string
  default = "ggabbita-test-s3buckets-lambda"
}

variable "output_bucket_name" {
  type    = string
  default = "test-s3buckets-lambda-ggabbita"
}

variable "environment" {
  type    = string
  default = "dev"
}