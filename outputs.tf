# A dedicated place for outputs means they will always be able to be easily found.

# Output values for the secret itself.
output "secret" {
  value       = { for key, value in aws_secretsmanager_secret.secret : key => value }
  description = "Collection of outputs for the secret."
}

# Outputs for the secret version module that is called in `aws_secret.tf`.
# The `merge` function allows it to always display one(1) value, even though it could be one of two modules being called
# The for loop iterates through the output values so they can be better parsed as inputs later on.
output "secret_version" {
  value = merge(
    {
      for key, value in module.secret_version_string : key => value
    },
    {
      for key, value in module.secret_version_binary : key => value
    }
  )
  description = "Collection of outputs for the secret version."
}
