# Secret Version

Basic quickstart for creating a Secret Version resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
module "secret" {
  source    = "so1omon563/secrets-manager/aws//modules/secret-version"
  version   = "1.2.0" # Replace with appropriate version
  secret_id = "valid_secret_id"

  //  secret_string = See `Populating the secret`
  //  secret_binary = See `Populating the secret`
  //  secret_key_value_pair = See `Populating the secret`
}
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret"></a> [secret](#module\_secret) | so1omon563/secrets-manager/aws//modules/secret-version | 1.2.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
