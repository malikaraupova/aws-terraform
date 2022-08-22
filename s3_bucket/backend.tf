terraform {
  backend "s3" {
    bucket = "shreecloud-terraform"
    key    = "state/s3_bucket"
    region = "us-east-1"
  }
}
