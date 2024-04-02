output "random_password" {
  value = data.aws_secretsmanager_random_password.random_password
}
