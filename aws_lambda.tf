# resource "aws_lambda_permission" "s3_invoke_permission" {
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.Lambda_Function
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.terraform_ggdevops_s3.arn
# }

# # Add S3 event trigger to Lambda function
# resource "aws_s3_bucket_notification" "lambda_s3_trigger" {
#   bucket = aws_s3_bucket.terraform_ggdevops_s3

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.Lambda_Function.arn
#     events              = ["s3:ObjectCreated:*"]
#   }
# }