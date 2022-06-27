variable "name" {}

variable "tags" {}

variable "secret_name" {}

variable "secret_string" {}

provider "aws" {
  default_tags {
    tags = var.tags
  }
}

module "secret" {
  source = "../../../"

  name = var.name
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_name   = "mysecret"
  secret_string = "test secret"
}
output "secret" { value = module.secret }
