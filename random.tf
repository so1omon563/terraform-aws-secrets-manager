# Generates a 2 byte random number that we will append to the secret name.
resource "random_id" "secret-random" {
  byte_length = 2
}
