#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
resource "random_string" "short" {
  length  = 7
  special = false
  upper   = false
}


module "terraform_state_backend" {

  source     = "git::https://github.com/afreisinger/terraform-aws-tfstate-backend.git"
  namespace  = "test-website"
  stage      = "production-tenant"
  name       = "app"
  attributes = ["tfstate", random_string.short.result]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = true
  dynamodb_enabled                   = false
}

module "test_website" {
  source      = "../../"
  name_prefix = "test-website"
  author      = "John Doe"
  email       = "johndoe@gmail.com"
  environment = "Testing"

  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.acm_provider
  }

  website_domain_name = "test.com"

  create_acm_certificate = true

  create_route53_hosted_zone = true

  aws_accounts_with_read_view_log_bucket = ["mock_account"]

  website_server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  log_bucket_force_destroy = false
}
