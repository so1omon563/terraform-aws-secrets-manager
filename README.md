# Secret in Secrets Manager

Creates a secret in Secrets Manager that can be retrieved later.

Please note that this module does **NOT** provide functionality to automatically rotate secrets at this time. You will need to set up rotation separately.

For more information on secret rotation, please see [Rotation Configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret#rotation-configuration).
The [Rotate Secrets section in the Secrets Manager User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets_strategies.html) provides additional information about deploying a prebuilt Lambda functions for supported credential rotation (e.g., RDS) or deploying a custom Lambda function.

### Populating the secret

This module is designed to create a one-off secret by passing in a variable at run-time. **DO NOT** place your secrets in source control.

There are three input variables associated with passing in a secret - `secret_string`, `secret_binary`, or `secret_key_value_pair` as outlined in the `Input Variables` section below.

If none of these options are passed in, the secret will be created, but will not contain a secret value.

If desired, the secret value can also be independently maintained using the `secret_version` submodule in the `modules` directory.

There are multiple options for passing in the secret value.

The most common options include:

#### Use a .tfvars file

Use a `terraform.tfvars` file that contains the value of `secret_string`, `secret_binary`, or `secret_key_value_pair`.

Make sure that you have `terraform.tfvars` in your `.gitignore` so it doesn't accidentally get committed.

An example of the format for that is here:

```hcl

# terraform.tfvars

# Only one of these values can be passed in. They are not compatible with each other

secret_string = "string_value"
secret_binary = "YmluYXJ5X3ZhbHVl"
secret_key_value_pair = {
    test1 = "secret1"
    test2 = "secret2"
  }

```

#### Pass in input variable on command line

Pass in the value of `secret_string`, `secret_binary`, or `secret_key_value_pair` on the command line when running Terraform.

An example of `secret_string` is here:

```shell

terraform apply -var="secret_string=string_value"

```

Depending on how you are calling the module, this option may not always work as expected.

#### Pass in input variable using environment variables

You can also set your input variable as an environment variable in your shell prior to running Terraform.

An example of `secret_string` is here:

```shell

export TF_VAR_secret_string=string_value
terraform apply

```

### Ignoring changes

By default, this module will ignore changes to a secret value after it is first created. If you wish to update the secret version with a new value, you can set the `ignore_changes` variable to `true`.

This will create a new secret version that can be updated any time it detects a change in the secret value.

### Tearing down a secret

When tearing down a secret, please note that it will remain in Secrets Manager for a minimum of 7 days, so the secret name cannot be re-used during that time.

By default, the secret name has a randomly generated hash at the end of it to help prevent this issue. That behavior can be overridden by using the `secret_name_override` variable.

If you wish to force delete the secret, you will need to use the CLI.

`aws secretsmanager delete-secret --secret-id <secret-name> --force-delete-without-recovery`

Examples for use can be found under the [examples](https://github.com/so1omon563/terraform-aws-secrets-manager/tree/main/examples) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret_version_binary"></a> [secret\_version\_binary](#module\_secret\_version\_binary) | ./modules/secret-version | n/a |
| <a name="module_secret_version_string"></a> [secret\_version\_string](#module\_secret\_version\_string) | ./modules/secret-version | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [random_id.secret-random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the secret. If not provided, a default value based on `name` and `secret_name` values will be used. | `string` | `null` | no |
| <a name="input_ignore_changes"></a> [ignore\_changes](#input\_ignore\_changes) | To ignore changes to the secret or not. This allows for changing the secret version after initial creation if desired. | `bool` | `true` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of the KMS key to encrypt the secret with. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | Optional JSON resource policy to attach to the secret. Suggest using Terraform to generate this policy using the `aws_iam_policy_document` resource. | `string` | `null` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. | `string` | `30` | no |
| <a name="input_secret_binary"></a> [secret\_binary](#input\_secret\_binary) | Specifies binary data that you want to encrypt and store in this version of the secret. Needs to be encoded to base64. Cannot be used in conjunction with `secret_string` or `secret_key_value_pair`. | `string` | `null` | no |
| <a name="input_secret_key_value_pair"></a> [secret\_key\_value\_pair](#input\_secret\_key\_value\_pair) | Specifies a key-value pair in a map of strings that you want to encrypt and store in this version of the secret. Cannot be used in conjunction with `secret_string` or `secret_binary`.<br><br>  Secrets Manager supports storing key-value pairs as secrets. We can pass those in as a map of strings, and it will be automatically converted to the JSON that is needed on the back end.<br><br>  An example of a key-value pair being passed in is here:<pre>secret_key_value_pair = {<br>    test1 = "secret1"<br>    test2 = "secret2"<br>  }</pre> | `map(string)` | `null` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Will be appended to the `name` variable to create the name of the secret. If not provided, the secret will be named with only the `name` variable. | `string` | `null` | no |
| <a name="input_secret_name_override"></a> [secret\_name\_override](#input\_secret\_name\_override) | Used if there is a need to specify a secret name outside of the standardized nomenclature. For example, if importing a secret that doesn't follow the standard naming formats. | `string` | `null` | no |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | Specifies text data that you want to encrypt and store in this version of the secret. Cannot be used in conjunction with `secret_key_value_pair` or `secret_binary`. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_version_stages"></a> [version\_stages](#input\_version\_stages) | Specifies a list of staging labels that are attached to this version of the secret. A staging label must be unique to a single version of the secret. If you specify a staging label that's already associated with a different version of the same secret then that staging label is automatically removed from the other version and attached to this version. If you do not specify a value, then AWS Secrets Manager automatically moves the staging label `AWSCURRENT` to this new version on creation. | `set(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret"></a> [secret](#output\_secret) | Collection of outputs for the secret. |
| <a name="output_secret_version"></a> [secret\_version](#output\_secret\_version) | Collection of outputs for the secret version. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
