variable iam_role_name {
  type = string
  default = "lambda_list_buckets_role"
}

variable lambda_name {
  type = string
  default = "list_buckets_lambda"
}

variable output_bucket_name {
  type = string
  default = "lambda_list_buckets_role"
}

variable environment {
  type = string
  default = "dev"
}