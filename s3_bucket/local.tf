locals {
  environment = terraform.workspace
  s3_info     = lookup(var.environment, local.environment)
  aws_account = data.aws_caller_identity.current.account_id
  bucket_name = "${local.aws_account}-auth0-user-profiles-${local.environment}"
}
