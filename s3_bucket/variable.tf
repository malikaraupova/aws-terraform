variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "name of the env example dev,qa"
  type        = map(any)
}
