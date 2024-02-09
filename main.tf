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
  name               = var.iam_role_name
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.output_bucket_name.arn}/*"
    ]
  }
  statement {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::*",                           # Allow listing all buckets
      "${aws_s3_bucket.output_bucket_name.arn}/*" # Allow writing to output bucket
    ]
  }
}
