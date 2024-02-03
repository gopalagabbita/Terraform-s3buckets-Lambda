resource "aws_s3_bucket" "terraform_ggdevops_s3" {
  bucket = "terraform_ggdevops_s3"
  acl    = "private"

  tags = {
    environment = "developement"
  }

}