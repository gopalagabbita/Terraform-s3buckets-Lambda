resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python/s3buckets.zip"
  function_name = "Lambda_Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}