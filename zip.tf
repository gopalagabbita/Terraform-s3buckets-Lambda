# data "archive_file" "zip_the_python_code" {
#   type        = "zip"
#   source_dir  = "${path.module}/python/"
#   output_path = "${path.module}/python/${var.handler_name}.zip"
# }