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
