# A dedicated place for variables means they will always be able to be easily found.

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix. If this, or `var.secret_name_override` are not provided, the secret will be named 'secret', with a random hex string appended."
  default     = null
}

variable "secret_name" {
  type        = string
  description = "Will be appended to the `name` variable to create the name of the secret. If not provided, the secret will be named with only the `name` variable."
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret.tf`
  default = null
}

variable "secret_name_override" {
  type        = string
  description = "Used if there is a need to specify a secret name outside of the standardized nomenclature. For example, if you have a specific naming pattern that falls outside of the defaults this module uses, or if importing a secret that doesn't follow the standard naming formats."
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret.tf`
  default = null
}

variable "description" {
  description = "Description of the secret. If not provided, a default value based on `name` and `secret_name` values will be used."
  type        = string
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret.tf`
  default = null
}

variable "kms_arn" {
  description = "ARN of the KMS key to encrypt the secret with."
  type        = string
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret.tf`
  default = null
}

variable "policy" {
  description = "Optional JSON resource policy to attach to the secret. Suggest using Terraform to generate this policy using the `aws_iam_policy_document` resource."
  type        = string
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret.tf`
  default = null
}

variable "recovery_window_in_days" {
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days."
  type        = string
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  default = 30
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "secret_string" {
  type        = string
  description = "Specifies text data that you want to encrypt and store in this version of the secret. Cannot be used in conjunction with `secret_key_value_pair` or `secret_binary`."
  # Setting the `sensitive` value to `true` obfuscates the value from any outputs. It will still be present in the state file, however.
  # That is why it's important to ensure that the bucket you keep your state file in is encrypted.
  sensitive = true
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret_version.tf`
  default = null
}

variable "secret_key_value_pair" {
  type        = map(string)
  description = <<EOT
  Specifies a key-value pair in a map of strings that you want to encrypt and store in this version of the secret. Cannot be used in conjunction with `secret_string` or `secret_binary`.

  Secrets Manager supports storing key-value pairs as secrets. We can pass those in as a map of strings, and it will be automatically converted to the JSON that is needed on the back end.

  An example of a key-value pair being passed in is here:

```
  secret_key_value_pair = {
    test1 = "secret1"
    test2 = "secret2"
  }
```
EOT
  # Setting the `sensitive` value to `true` obfuscates the value from any outputs. It will still   be present in the state file, however.
  # That is why it's important to ensure that the bucket you keep your state file in is encrypted.
  sensitive = true
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret_version.tf`
  default = null
}

variable "secret_binary" {
  type        = string
  description = "Specifies binary data that you want to encrypt and store in this version of the secret. Needs to be encoded to base64. Cannot be used in conjunction with `secret_string` or `secret_key_value_pair`."
  # Setting the `sensitive` value to `true` obfuscates the value from any outputs. It will still   be present in the state file, however.
  # That is why it's important to ensure that the bucket you keep your state file in is encrypted.
  sensitive = true
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret_version.tf`
  default = null
}

variable "version_stages" {
  type        = set(string)
  description = "Specifies a list of staging labels that are attached to this version of the secret. A staging label must be unique to a single version of the secret. If you specify a staging label that's already associated with a different version of the same secret then that staging label is automatically removed from the other version and attached to this version. If you do not specify a value, then AWS Secrets Manager automatically moves the staging label `AWSCURRENT` to this new version on creation."
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  # By setting this default to `null`, we can easily determine if it needs to be used or not in `aws_secret_version.tf`
  default = null
}

variable "ignore_changes" {
  description = "To ignore changes to the secret or not. This allows for changing the secret version after initial creation if desired."
  type        = bool
  # By setting a default value, we make it easier to consume the module without having to decide on specifics ahead of time.
  # The default can be overridden by passing in a new value.
  default = true
}
