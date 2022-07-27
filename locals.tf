# A dedicated place for locals means they will always be able to be easily found.

locals {
  secret_name        = var.secret_name_override != null ? var.secret_name_override : var.secret_name == null ? format("%s-%s", var.name, random_id.secret-random.hex) : format("%s-%s-%s", var.name, var.secret_name, random_id.secret-random.hex)
  secret_description = var.description == null ? local.secret_name : var.description
  tags               = var.tags
}
