resource "aws_dynamodb_table" "db" {
  count          = length(var.dynamodb)
  name           = lookup(var.dynamodb[count.index], "name")
  read_capacity  = lookup(var.dynamodb[count.index], "read", 20)
  write_capacity = lookup(var.dynamodb[count.index], "write", 20)
  hash_key       = lookup(var.dynamodb[count.index], "hash_key", "LockID")
  range_key      = lookup(var.dynamodb[count.index], "range_key", null)

  attribute {
    name = lookup(var.dynamodb[count.index], "hash_key", "LockID")
    type = lookup(var.dynamodb[count.index], "hash_type", "S")
  }

  # dynamic "attribute" {
  #   for_each = var.db_attributes
  #   content {
  #     name = attribute.value.name
  #     type = attribute.value.type
  #   }
  # }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = lookup(var.dynamodb[count.index], "ttl", false)
  }


  tags = {
    Name = lookup(var.dynamodb[count.index], "name")
    App  = lookup(var.dynamodb[count.index], "tag", null)
  }
}