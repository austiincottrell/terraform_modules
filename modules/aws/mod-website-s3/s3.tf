resource "aws_s3_bucket" "website_s3" {
  count      = length(var.website) > 0 ? length(var.website) : 0
  bucket     = lookup(var.website[count.index], "name", null)

  policy     = lookup(var.website[count.index], "policy", null)

  versioning {
    enabled  = lookup(var.website[count.index], "versioning", false)
  }

  website {
    index_document = lookup(var.website[count.index], "home_page", "index.html")
    error_document = lookup(var.website[count.index], "error_page", "error.html")
  }

  logging {
    target_bucket = var.logging_bucket
    target_prefix = "log/${lookup(var.website[count.index], "name", null)}/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = lookup(var.website[count.index], "kms", null)
        sse_algorithm     = var.kms_encrypt == true ? "aws:kms" : "AES256"
      }
    }
  }

  tags = {
    Name = lookup(var.website[count.index], "name")
    App  = lookup(var.website[count.index], "tag", null)
  }
}

resource "aws_s3_bucket_public_access_block" "cloud1" {
  count = length(aws_s3_bucket.website_s3)

  bucket = aws_s3_bucket.website_s3[count.index].id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}