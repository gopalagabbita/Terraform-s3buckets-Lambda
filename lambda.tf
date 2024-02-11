

data "archive_file" "lambda_code" {
  type        = "zip"
  source_dir  = "lambda_source_code"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "list_buckets_lambda" {
  filename         = "lambda_function.zip"
  function_name    = var.lambda_name
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 90
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  environment {
    variables = {
      s3_bucket_name = "${var.output_bucket_name}"
    }
  }
  tags = {
    Name        = "${var.lambda_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = var.lambda_log_group
  retention_in_days = var.retention_in_days

  tags = {
    Name        = "${var.lambda_name}_log_group"
    Environment = "${var.environment}"
  }
}