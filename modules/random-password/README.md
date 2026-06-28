# Random Password

Creates a random password that can be used to populate secrets. Note that the password will be changed each time this module is run.
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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.38, < 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_random_password.random_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_random_password) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_exclude_characters"></a> [exclude\_characters](#input\_exclude\_characters) | String of the characters that you don't want in the password. | `string` | `null` | no |
| <a name="input_exclude_lower_case"></a> [exclude\_lower\_case](#input\_exclude\_lower\_case) | Specifies whether to exclude lowercase letters from the password. | `bool` | `false` | no |
| <a name="input_exclude_numbers"></a> [exclude\_numbers](#input\_exclude\_numbers) | Specifies whether to exclude numbers from the password. | `bool` | `false` | no |
| <a name="input_exclude_punctuation"></a> [exclude\_punctuation](#input\_exclude\_punctuation) | Specifies whether to exclude the following punctuation characters from the password: `! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { \| } ~ .`<br>` | `bool` | `false` | no |
| <a name="input_exclude_upper_case"></a> [exclude\_upper\_case](#input\_exclude\_upper\_case) | Specifies whether to exclude uppercase letters from the password. | `bool` | `false` | no |
| <a name="input_include_space"></a> [include\_space](#input\_include\_space) | Specifies whether to include the space character in the password. | `bool` | `false` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | The length of the password. | `number` | `24` | no |
| <a name="input_require_each_included_type"></a> [require\_each\_included\_type](#input\_require\_each\_included\_type) | Specifies whether to include at least one upper and lowercase letter, one number, and one punctuation. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_random_password"></a> [random\_password](#output\_random\_password) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
