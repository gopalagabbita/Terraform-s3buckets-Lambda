# resource "aws_lambda_function" "terraform_lambda_func" {
#   filename      = "${path.module}/python/s3buckets.zip"
#   function_name = "Lambda_Function"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "index.lambda_handler"
#   runtime       = "python3.12"
#   depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
# }

# resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
#   bucket = aws_s3_bucket.terraform_ggdevops_s3.id
#   lambda_function {
#     lambda_function_arn = aws_lambda_function.terraform_lambda_func.arn
#     events              = ["s3:ObjectCreated:", "s3:ObjectRemoved:"]

#   }
# }

# resource "aws_lambda_permission" "allow_terraform_bucket" {
#   statement_id  = "AllowExecutionFromS3Bucket"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.s3_copy_function.arn
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.source_bucket.arn
# }

