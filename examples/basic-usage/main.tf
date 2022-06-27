provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

module "secret" {
  source  = "so1omon563/secrets-manager/aws"
  version = "0.1.0" # Replace with appropriate version

  name = "example-secret"
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_name = "mysecret"

  # Secret value - should not be placed in source control
  # Example value(s) placed here to show how calling the module can work.
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = "See `Populating the secret` in README.md"
  //  secret_binary = See `Populating the secret` in README.md
  //  secret_key_value_pair = See `Populating the secret` in README.md

  tags = {
    example = "true"
  }
}
output "secret" {
  value = module.secret
}
