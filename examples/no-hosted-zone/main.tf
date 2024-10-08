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

  create_route53_hosted_zone = false
  route53_hosted_zone_id     = "0123456789ABCDEFGHIJK"


  aws_accounts_with_read_view_log_bucket = ["mock_account"]
}
