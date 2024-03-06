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

module "secret-name-only" {
  source = "../../../"

  name = var.name
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = "test secret"
}
output "secret-name-only" { value = module.secret-name-only }

module "secret_name_override" {
  source = "../../../"

  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_name_override = "/mysecretname/here"
  secret_string        = "test secret"
}
output "secret_name_override" { value = module.secret_name_override }

module "default_secret_name" {
  source = "../../../"

  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = "test secret"
}
output "default_secret_name" { value = module.default_secret_name }
