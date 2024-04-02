data "aws_secretsmanager_random_password" "random_password" {
  password_length            = var.password_length
  exclude_characters         = var.exclude_characters
  exclude_lowercase          = var.exclude_lower_case
  exclude_numbers            = var.exclude_numbers
  exclude_punctuation        = var.exclude_punctuation
  exclude_uppercase          = var.exclude_upper_case
  include_space              = var.include_space
  require_each_included_type = var.require_each_included_type
}
