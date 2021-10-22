##############
##### S3 #####
##############

resource "aws_s3_bucket" "s3" {
  depends_on = [aws_s3_bucket.logging_s3]
  count      = length(var.s3_bucket) >= 1 ? length(var.s3_bucket) : 0
  bucket     = lookup(var.s3_bucket[count.index], "name", null)
  acl        = lookup(var.s3_bucket[count.index], "acl", null)

  policy = lookup(var.s3_bucket[count.index], "policy", null)

  versioning {
    enabled = lookup(var.s3_bucket[count.index], "versioning", false)
  }

  lifecycle_rule {
    id       = lookup(var.lifecycle_rule[count.index], "id", null)
    enabled  = lookup(var.lifecycle_rule[count.index], "enabled", false)
    prefix   = lookup(var.lifecycle_rule[count.index], "prefix", null)

    transition {
      days          = lookup(var.lifecycle_rule[count.index], "glacier", null)
      storage_class = length(lookup(var.lifecycle_rule[count.index], "glacier", 0)) > 0 ? "GLACIER" : null
    }

    noncurrent_version_transition {
      days          = lookup(var.lifecycle_rule[count.index], "glacier_version", null)
      storage_class = length(lookup(var.lifecycle_rule[count.index], "glacier_version", 0)) > 0 ? "GLACIER" : null
    }

    expiration {
      days = lookup(var.lifecycle_rule[count.index], "deletion", null)
    }

    noncurrent_version_expiration {
      days = lookup(var.lifecycle_rule[count.index], "deletion_version", null)
    }
  }

  logging {
    target_bucket = length(var.logging_bucket) > 0 ? var.logging_bucket : aws_s3_bucket.logging_s3[0].id
    target_prefix = "log/${lookup(var.s3_bucket[count.index], "name", null)}/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = lookup(var.s3_bucket[count.index], "kms_arn", null)
        sse_algorithm     = lookup(var.s3_bucket[count.index], "kms_arn", null) != null ? "aws:kms" : "AES256"
      }
    }
  }

  tags = {
    Name = lookup(var.s3_bucket[count.index], "name", null)
    App  = lookup(var.s3_bucket[count.index], "tag", null)
  }
}

###############
### Website ###
###############

resource "aws_s3_bucket" "website_s3" {
  depends_on = [aws_s3_bucket.s3, aws_s3_bucket.logging_s3]
  count      = length(var.website) > 0 ? length(var.website) : 0
  bucket     = lookup(var.website[count.index], "name", null)

  policy     = lookup(var.website[count.index], "policy", null)

  versioning {
    enabled  = lookup(var.website[count.index], "versioning", false)
  }

  lifecycle_rule {
    id       = lookup(var.website_lifecycle_rule[count.index], "id", null)
    enabled  = lookup(var.website_lifecycle_rule[count.index], "enabled", false)
    prefix   = lookup(var.website_lifecycle_rule[count.index], "prefix", null)

    expiration {
      days = lookup(var.website_lifecycle_rule[count.index], "deletion", null)
    }

    noncurrent_version_expiration {
      days = lookup(var.website_lifecycle_rule[count.index], "deletion_version", null)
    }
  }

  website {
    index_document = lookup(var.website[count.index], "home_page", "index.html")
    error_document = lookup(var.website[count.index], "error_page", "error.html")
  }

  # grant {
  #   type        = "Group"
  #   permissions = ["READ_ACP"]
  #   uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
  # }

  logging {
    target_bucket = length(var.logging_bucket) > 0 ? var.logging_bucket : aws_s3_bucket.logging_s3[0].id
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

###############
### Logging ###
###############

resource "aws_s3_bucket" "logging_s3" {
  count      = length(var.logging) > 0 ? length(var.logging) : 0
  bucket     = lookup(var.logging[count.index], "name", null)
  acl        = lookup(var.logging[count.index], "acl", null)

  policy     = lookup(var.logging[count.index], "policy", null)

  versioning {
    enabled  = lookup(var.logging[count.index], "versioning", false)
  }

  lifecycle_rule {
    id       = lookup(var.logging_lifecycle_rule[count.index], "id", null)
    enabled  = lookup(var.logging_lifecycle_rule[count.index], "enabled", false)
    prefix   = lookup(var.logging_lifecycle_rule[count.index], "prefix", null)

    transition {
      days          = lookup(var.logging_lifecycle_rule[count.index], "glacier", null)
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = lookup(var.logging_lifecycle_rule[count.index], "glacier_version", null)
      storage_class = "GLACIER"
    }

    expiration {
      days = lookup(var.logging_lifecycle_rule[count.index], "deletion", null)
    }

    noncurrent_version_expiration {
      days = lookup(var.logging_lifecycle_rule[count.index], "deletion", null)
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = lookup(var.logging[count.index], "kms", null)
        sse_algorithm     = var.kms_encrypt == true ? "aws:kms" : "AES256"
      }
    }
  }

  tags = {
    Name = lookup(var.logging[count.index], "name", null)
    App  = lookup(var.logging[count.index], "tag", null)
  }
}

resource "aws_s3_bucket_public_access_block" "cloud" {
  count = length(aws_s3_bucket.logging_s3) 

  bucket = aws_s3_bucket.logging_s3[count.index].id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "cloud1" {
  count = length(aws_s3_bucket.website_s3)

  bucket = aws_s3_bucket.website_s3[count.index].id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "cloud2" {
  count = length(aws_s3_bucket.s3)

  bucket = aws_s3_bucket.s3[count.index].id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
