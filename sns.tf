resource "aws_sns_topic" "my-sns-topic" {
    name = "Test"
    policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": {
            "Service": "s3.amazonaws.com"
            },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:us-east-1:318569110813:Test",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.s3-bucket.arn}"}
        }
    }]
}
POLICY
}