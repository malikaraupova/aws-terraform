module "s3_bucket" {
  source = "./modules/"

  bucket = var.bucket_name

  tags = {
    env   = var.env
    owner = var.owner
  }
}
