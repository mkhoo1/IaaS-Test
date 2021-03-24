provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket  = "my-tf-test-bucket"
  acl     = "public-read-write"

  versioning {
    enabled   = false
    mfa_delete  = false
  }

  tags = {
    "key"       = "Name"
    "value"     = "shift-left"
  }
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "Policy1556000995461",
    "Statement": [
        {
            "Sid": "Stmt1556000991881",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::automation-public-bucket/*"
        }
    ]
  }
  POLICY
}

resource "aws_s3_bucket_public_access_block" "bucketACL" {
  bucket = "${aws_s3_bucket.bucket.id}"
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}