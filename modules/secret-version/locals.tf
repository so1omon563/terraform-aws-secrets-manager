# A dedicated place for locals means they will always be able to be easily found.

locals {
  # Sets a flag to determine which output should be generated from the `aws_secretsmanager_secret_version` resource.
  # Note that this test does not have an '== true' piece. If the item you are testing is a `bool` type, you don't need to specify a test for a `true` value.
  ignore_count = var.ignore_changes ? 1 : 0
}
