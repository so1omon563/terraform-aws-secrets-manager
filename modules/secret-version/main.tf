# Don't put everything in main.tf
# Separate files for separate resources makes it easier to read and collaborate.
# The general rule is to have a separate file for each resource type.
# Since Terraform can work with multiple providers in a single module, we prefix the appropriate filenames with the name of the provider.
# We generally use `-` separators in file names for resources and the resouce names themselves.
# We use `_`separators for everything else.

# The main module calls this submodule to create the secret_version.
# By making it a submodule instead of just baking it into the main module, it allows for working with secret_versions independently of the main secret module.
# Wherever possible, it is preferred to create submodules that the main module calls for this exact kind of use case.
terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38"
    }
  }
}
