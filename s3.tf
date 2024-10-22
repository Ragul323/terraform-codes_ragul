provider "aws" {
  region = "ap-south-1"  
}
resource "aws_s3_bucket" "pune_tasks" {
  bucket = "pune-tasks"
  acl    = "private"
}


