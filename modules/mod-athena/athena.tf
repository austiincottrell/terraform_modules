resource "aws_athena_database" "cloud" {
  count  = length(var.athena) > 0 ? 1 : 0
  name   = lookup(var.athena[count.index], "name")
  bucket = lookup(var.athena[count.index], "bucket")

  encryption_configuration {
    encryption_option = lookup(var.athena[count.index], "encrytpion_type", null)
    kms_key           = lookup(var.athena[count.index], "kms_key", null)
  }
}

resource "aws_athena_workgroup" "cloud" {
  count  = length(var.athena) > 0 ? 1 : 0
  name   = lookup(var.athena[count.index], "name")

  configuration {
    enforce_workgroup_configuration    = lookup(var.athena[count.index], "workgroup_enabled", true)
    publish_cloudwatch_metrics_enabled = lookup(var.athena[count.index], "cloudwatch_enabled", true)

    result_configuration {
      output_location = "s3://${lookup(var.athena[count.index], "bucket")}/${lookup(var.athena[count.index], "bucket_prefix", "output/")}"

      encryption_configuration {
        encryption_option = lookup(var.athena[count.index], "encrytpion_type", null)
        kms_key_arn       = lookup(var.athena[count.index], "kms_key", null)
      }
    }
  }
}

resource "aws_athena_named_query" "cloud" {
  count     = length(var.query) > 1 ? length(var.query) : 0
  name      = lookup(var.query[count.index], "name", null)
  workgroup = aws_athena_workgroup.cloud[0].id
  database  = aws_athena_database.cloud[0].name
  query     = lookup(var.query[count.index], "sql_command", null)
}