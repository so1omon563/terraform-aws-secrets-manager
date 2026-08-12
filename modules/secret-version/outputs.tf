# A dedicated place for outputs means they will always be able to be easily found.

# Outputs for the secret version.
# Since some of the outputs of the `aws_secretsmanager_secret_version` resource are sensitive, we call out the individual outputs we want.
# Since there is a possibility for one of two resources being created based on `var.ignore_changes`, we perform a test to see which one needs to be output.
# We use the value of `local.ignore_count` to test against.
output "secret_version" {
  value = {
    arn            = local.ignore_count > 0 ? aws_secretsmanager_secret_version.version_ignore[0].arn : aws_secretsmanager_secret_version.version_change[0].arn
    id             = local.ignore_count > 0 ? aws_secretsmanager_secret_version.version_ignore[0].id : aws_secretsmanager_secret_version.version_change[0].id
    secret_id      = local.ignore_count > 0 ? aws_secretsmanager_secret_version.version_ignore[0].secret_id : aws_secretsmanager_secret_version.version_change[0].secret_id
    version_id     = local.ignore_count > 0 ? aws_secretsmanager_secret_version.version_ignore[0].version_id : aws_secretsmanager_secret_version.version_change[0].version_id
    version_stages = local.ignore_count > 0 ? aws_secretsmanager_secret_version.version_ignore[0].version_stages : aws_secretsmanager_secret_version.version_change[0].version_stages
    ignore_changes = var.ignore_changes
  }
  description = "Collection of outputs for the secret version."
}
