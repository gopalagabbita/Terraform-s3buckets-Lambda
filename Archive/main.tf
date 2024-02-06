data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.iam_role_name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::*",  # Allow listing all buckets
      "arn:aws:s3:::${var.output_bucket_name}/*"  # Allow writing to output bucket
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda_list_buckets_policy"
  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

data "archive_file" "lambda_code" {
  type = "zip"
  source_dir = "lambda_source_code"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "list_buckets_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "${var.lambda_name}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout 	   = 90
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  environment {
    variables = {
      s3_bucket_name = "${var.output_bucket_name}"
    }
  }
  tags = {
    Name        = "ListBucketsLambda"
    Environment = "${var.environment}"
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.list_buckets_lambda.function_name}"
  retention_in_days = 7

  tags = {
    Name        = "ListBucketsLambdaLogs"
    Environment = "${var.environment}"
  }
}
