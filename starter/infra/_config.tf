terraform {
  backend "s3" {
    bucket = "udacity-tf-sardor"
    key    = "terraform/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
  profile = "udacity"

  default_tags {
    tags = local.tags
  }
}
