# A dedicated place for variables means they will always be able to be easily found.

variable "secret_id" {
  type        = string
  description = "Specifies the secret to which you want to add a new version. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. The secret must already exist."
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
