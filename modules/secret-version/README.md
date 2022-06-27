**This README is manually maintained, and may not be up to date. For automated technical documentation, please refer to [`TF-DOCS.md`](TF-DOCS.md).**

# Secret Version

Creates a secret version in an existing secret in Secrets Manager. Note that the top level `secrets-manager` module calls this submodule to populate secrets.

### Populating the secret

This module is designed to create a one-off secret by passing in a variable at run-time. **DO NOT** place your seecrets in source control.

There are three input variables associated with passing in a secret - `secret_string`, `secret_binary`, or `secret_key_value_pair` as outlined in the `Input Variables` section below.

If none of these options are passed in, the secret will be created, but will not contain a secret value.

There are multiple options for passing in the secret value.

The most common options include:

#### Use a .tfvars file

Use a `terraform.tfvars` file that contains the value of `secret_string`, `secret_binary`, or `secret_key_value_pair`.

Make sure that you have `terraform.tfvars` in your `.gitignore` so it doesn't accidentally get committed.

An example of the format for that is here:
```
# terraform.tfvars
# Only one of these values can be passed in. They are not compatible with each other.

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

```
terraform apply -var="secret_string=string_value"
```

Depending on how you are calling the module, this option may not always work as expected.

#### Pass in input variable using environment variables

You can also set your input variable as an environment variable in your shell prior to running Terraform.

An example of `secret_string` is here:

```
$ export TF_VAR_secret_string=string_value
$ terraform apply
```

### Ignoring changes

By default, this module will ignore changes to a secret value after it is first created. If you wish to update the secret version with a new value, you can set the `ignore_changes` variable to `true`.

This will create a new secret version that can be updated any time it detects a change in the secret value.

Examples for use can be found under the [examples](https://github.com/so1omon563/terraform-aws-secrets-manager/tree/main/examples) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret_version.version_change](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.version_ignore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ignore_changes"></a> [ignore\_changes](#input\_ignore\_changes) | To ignore changes to the secret or not. This allows for changing the secret version after initial creation if desired. | `bool` | `true` | no |
| <a name="input_secret_binary"></a> [secret\_binary](#input\_secret\_binary) | Specifies binary data that you want to encrypt and store in this version of the secret. Needs to be encoded to base64. Cannot be used in conjunction with `secret_string` or `secret_key_value_pair`. | `string` | `null` | no |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist. | `string` | n/a | yes |
| <a name="input_secret_key_value_pair"></a> [secret\_key\_value\_pair](#input\_secret\_key\_value\_pair) | Specifies a key-value pair in a map of strings that you want to encrypt and store in this version of the secret. Cannot be used in conjunction with `secret_string` or `secret_binary`.<br><br>  Secrets Manager supports storing key-value pairs as secrets. We can pass those in as a map of strings, and it will be automatically converted to the JSON that is needed on the back end.<br><br>  An example of a key-value pair being passed in is here:<pre>secret_key_value_pair = {<br>    test1 = "secret1"<br>    test2 = "secret2"<br>  }</pre> | `map(string)` | `null` | no |
| <a name="input_secret_string"></a> [secret\_string](#input\_secret\_string) | Specifies text data that you want to encrypt and store in this version of the secret. Cannot be used in conjunction with `secret_key_value_pair` or `secret_binary`. | `string` | `null` | no |
| <a name="input_version_stages"></a> [version\_stages](#input\_version\_stages) | Specifies a list of staging labels that are attached to this version of the secret. A staging label must be unique to a single version of the secret. If you specify a staging label that's already associated with a different version of the same secret then that staging label is automatically removed from the other version and attached to this version. If you do not specify a value, then AWS Secrets Manager automatically moves the staging label `AWSCURRENT` to this new version on creation. | `set(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_version"></a> [secret\_version](#output\_secret\_version) | Collection of outputs for the secret version. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
