module "secret" {
  source    = "so1omon563/secrets-manager/aws//modules/secret-version"
  version   = "1.2.0" # Replace with appropriate version
  secret_id = "valid_secret_id"

  //  secret_string = See `Populating the secret`
  //  secret_binary = See `Populating the secret`
  //  secret_key_value_pair = See `Populating the secret`
}
