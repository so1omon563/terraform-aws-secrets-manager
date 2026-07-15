# Secret

Basic quickstart for creating a Secret resource.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38, < 6.0"
    }
  }
}

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
  version = "1.4.0" # Replace with appropriate version

  name = "example-secret-replication"
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_name = "mysecret"

  # Secret value - should not be placed in source control
  # Example value(s) placed here to show how calling the module can work.
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = "See `Populating the secret` in README.md"
  //  secret_binary = See `Populating the secret` in README.md
  //  secret_key_value_pair = See `Populating the secret` in README.md

  replica_region_kms_map = {
    "us-west-1" = null
  }
  tags = {
    example = "true"
  }
}
output "secret" {
  value = module.secret
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38, < 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret"></a> [secret](#module\_secret) | so1omon563/secrets-manager/aws | 1.4.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret"></a> [secret](#output\_secret) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
