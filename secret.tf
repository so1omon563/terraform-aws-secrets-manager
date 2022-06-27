# Generates the secret resource
resource "aws_secretsmanager_secret" "secret" {
  # `name` value is dynamic based on if a `var.secret_name` value is passed in or not. If is not passed in, it only uses `var.name` to name the resource.
  # Using the `format` function to work with text comes from issues that used to exist with interpolation not always working correctly. It is not a best practice, but is a strong personal preference.
  name = var.secret_name == null ? format("%s-%s", var.name, random_id.secret-random.hex) : format("%s-%s-%s", var.name, var.secret_name, random_id.secret-random.hex)
  # `description` value is dynamic based on it a `var.sdescription` value is passed in or not. If not, the description is auto-generated.
  # Using the `format` function to work with text comes from issues that used to exist with interpolation not always working correctly. It is not a best practice, but is a strong personal preference.
  description = var.description == null ? var.secret_name == null ? "Secret for ${format("%s-%s", var.name, random_id.secret-random.hex)}" : "Secret for ${format("%s-%s-%s", var.name, var.secret_name, random_id.secret-random.hex)}" : var.description
  # Default value of `var.kms_arn` is `null`, so this is only used if a value is passed in.
  kms_key_id = var.kms_arn
  # Default value of `var.policy` is `null`, so this is only used if a value is passed in.
  policy                  = var.policy
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = local.tags
}
