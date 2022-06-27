# Since there is no way to use a dynamic `lifecycle` block, the workaround is to create one of two resources.
# One resource has an `ignore_changes` lifecycle set, and the other doesn't.

resource "aws_secretsmanager_secret_version" "version_ignore" {
  # If `var.ignore_changes` is `true`, builds 1 of this resource. This is the default.
  # If `var.ignore_changes` is `false`, it would build 0 of this resource.
  # Note that this test does not have an '== true' piece. If the item you are testing is a `bool` type, you don't need to specify a test for a `true` value.
  count     = var.ignore_changes ? 1 : 0
  secret_id = var.secret_id
  # Both `var.secret_string` and are set to `null` by default, so they only pass if there is a value.
  # If `var.secret_key_value_pair` is passed in it uses the `jsondecode` function to pass it in to the `secret_string` option.
  # Otherwise, it will pass in `var.secret_string` to the option.
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = var.secret_key_value_pair != null ? jsonencode(var.secret_key_value_pair) : var.secret_string
  # `var.secret_binary` is set to `null` by default, so it only passes it if there is a value.
  secret_binary  = var.secret_binary
  version_stages = var.version_stages
  lifecycle {
    ignore_changes = [
      secret_string,
      secret_binary
    ]
  }
}

resource "aws_secretsmanager_secret_version" "version_change" {
  # If `var.ignore_changes` is `true`, builds 0 of this resource. This is the default.
  # If `var.ignore_changes` is `false`, it would build 1 of this resource.
  # Note that this test does not have an '== true' piece. If the item you are testing is a `bool` type, you don't need to specify a test for a `true` value.
  count     = var.ignore_changes ? 0 : 1
  secret_id = var.secret_id
  # Both `var.secret_string` and are set to `null` by default, so they only pass if there is a value.
  # If `var.secret_key_value_pair` is passed in it uses the `jsondecode` function to pass it in to the `secret_string` option.
  # Otherwise, it will pass in `var.secret_string` to the option.
  #tfsec:ignore:GEN003 The variable is marked as "sensitive" in the module, so it won't be output. Will still be in state file, which should be encrypted / access limited if stored in S3.
  secret_string = var.secret_key_value_pair != null ? jsonencode(var.secret_key_value_pair) : var.secret_string
  # `var.secret_binary` is set to `null` by default, so it only passes it if there is a value.
  secret_binary  = var.secret_binary
  version_stages = var.version_stages
}
