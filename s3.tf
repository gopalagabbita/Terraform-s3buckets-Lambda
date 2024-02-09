resource "aws_s3_bucket" "output_bucket_name" {
    bucket = var.output_bucket_name

    tags = {
      environment = "${var.environment}"
      Name = "${var.output_bucket_name}"
    }
  
}