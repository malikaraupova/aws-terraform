module "s3_bucket" {
  source = "./modules/"
  count  = length(var.bucket_name)
  bucket = "${var.env}-${var.bucket_name[count.index]}"

  tags = {
    env   = var.env
    owner = var.owner
  }
}
