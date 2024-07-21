terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    region  = "us-east-1"
    bucket  = "test-website-production-tenant-www-tfstate-sukbrj3"
    key     = "terraform.tfstate"
    profile = ""
    encrypt = "true"
  }
}
