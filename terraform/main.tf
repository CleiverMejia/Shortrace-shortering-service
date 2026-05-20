terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

resource "aws_dynamodb_table" "short_urls" {
  name = "short_urls"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "shortCode"

  attribute {
    name = "shortCode"
    type = "S"
  }
}