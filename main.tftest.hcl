mock_provider "aws" {}

run "default_secret" {
  command = plan

  variables {
    secret_name_override = "example-secret"
    tags = {
      environment = "test"
    }
  }

  assert {
    condition     = aws_secretsmanager_secret.secret.name == "example-secret"
    error_message = "Expected the secret name override to be used."
  }

  assert {
    condition     = aws_secretsmanager_secret.secret.description == "example-secret"
    error_message = "Expected the default description to match the secret name."
  }

  assert {
    condition     = aws_secretsmanager_secret.secret.recovery_window_in_days == 30
    error_message = "Expected the recovery window to default to 30 days."
  }

  assert {
    condition     = aws_secretsmanager_secret.secret.tags.environment == "test"
    error_message = "Expected tags to be applied to the secret."
  }
}

run "secret_string_version" {
  command = plan

  variables {
    secret_name_override = "example-secret"
    secret_string        = "example"
  }

  assert {
    condition     = length(module.secret_version_string) == 1
    error_message = "Expected a string secret version when secret_string is set."
  }

  assert {
    condition     = length(module.secret_version_binary) == 0
    error_message = "Expected no binary secret version when secret_binary is unset."
  }
}

run "replicated_secret" {
  command = plan

  variables {
    secret_name_override = "example-secret"
    replica_region_kms_map = {
      us-west-2 = null
    }
  }

  assert {
    condition     = length(aws_secretsmanager_secret.secret.replica) == 1
    error_message = "Expected one replica block."
  }
}
