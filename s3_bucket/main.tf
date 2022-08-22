###########################
# Customer managed KMS key
###########################
resource "aws_kms_key" "kms_s3_key" {
  description             = "Key to protect S3 objects in auth0 bucket"
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 7
  is_enabled              = true
}

resource "aws_kms_alias" "kms_s3_key_alias" {
  name          = "alias/s3-key"
  target_key_id = aws_kms_key.kms_s3_key.key_id
}

########################
# Bucket creation
########################
resource "aws_s3_bucket" "auth0_bucket" {
  bucket = local.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms_s3_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  #logging {
  #  target_bucket = aws_s3_bucket.log_bucket.id
  #  target_prefix = "log/"
  #}

  lifecycle_rule {
    id      = "rule_delete_after_30days"
    enabled = true
    expiration {
      days = 30
    }
  }
}

########################
# Disabling bucket
# public access
########################
resource "aws_s3_bucket_public_access_block" "auth0_bucket_access" {
  bucket = aws_s3_bucket.auth0_bucket.id

  # Block public access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
