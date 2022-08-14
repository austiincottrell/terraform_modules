locals {
  secrets = {"username": var.username,
  "password": random_password.rds-password[0].result,
  "engine": "mysql",
  "host": var.rds_address,
  "port": 3306,
  "dbClusterIdentifier": var.cluster_identifier}
}

resource "aws_secretsmanager_secret" "my_secret" {
  count      = length(var.my_secret) > 0 ? length(var.my_secret) : 0
  name       = lookup(var.my_secret[count.index], "path", null)
  kms_key_id = var.kms_key
}

resource "aws_secretsmanager_secret_version" "secret" {
  count         = length(var.my_secret) > 0 ? length(var.my_secret) : 0
  secret_id     = aws_secretsmanager_secret.my_secret[count.index].id
  secret_string = random_password.password[count.index].result
}

resource "aws_secretsmanager_secret" "rds" {
  count      = length(var.rds_pass)
  name       = lookup(var.rds_pass[count.index], "path")
  kms_key_id = var.kms_key
}

resource "aws_secretsmanager_secret_version" "rds" {
  count         = length(var.rds_pass)
  secret_id     = aws_secretsmanager_secret.rds[count.index].id
  secret_string = length(var.rds_pass) > 1 ? random_password.rds-password[count.index].result : jsonencode(local.secrets)
}

resource "random_password" "password" {
  count            = length(var.my_secret) > 0 ? length(var.my_secret) : 0
  length           = 16
  upper            = true
  lower            = true
  number           = true
  special          = true
  override_special = "!&#"
}

resource "random_password" "rds-password" {
  count            = length(var.rds_pass)
  length           = 16
  upper            = true
  lower            = true
  number           = true
  special          = true
  override_special = "$_%"
}