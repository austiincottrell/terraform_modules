resource "aws_kms_key" "key" {
  count               = length(var.kms_keys_alias)
  enable_key_rotation = true
}

resource "aws_kms_alias" "key" {
  count         = length(var.kms_keys_alias)
  name          = "alias/${element(var.kms_keys_alias, count.index)}"
  target_key_id = aws_kms_key.key[count.index].key_id
}
