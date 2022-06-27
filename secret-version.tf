# Calls the `secret-version` submodule to add the secret value, depending on how one is or isn't passed in.

module "secret_version_string" {
  # If `var.secret_string` or `var.secret_key_value_pair` are passed in, it calls the module using these values.
  count     = var.secret_string != null || var.secret_key_value_pair != null && var.secret_binary == null ? 1 : 0
  source    = "./modules/secret-version"
  secret_id = aws_secretsmanager_secret.secret.id

  # `var.secret_string` is set to `null` by default, so it only passes it if there is a value.
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = var.secret_string
  # `var.secret_key_value_pair` is set to `null` by default, so it only passes it if there is a value.
  secret_key_value_pair = var.secret_key_value_pair
  version_stages        = var.version_stages
  ignore_changes        = var.ignore_changes
}

module "secret_version_binary" {
  # If `var.secret_binary` is passed in and `var.secret_string` is `null`, it calls the module using these values.
  count     = var.secret_binary != null && var.secret_string == null ? 1 : 0
  source    = "./modules/secret-version"
  secret_id = aws_secretsmanager_secret.secret.id

  # `var.secret_binary` is set to `null` by default, so it only passes it if there is a value.
  secret_binary  = var.secret_binary
  version_stages = var.version_stages
  ignore_changes = var.ignore_changes
}
