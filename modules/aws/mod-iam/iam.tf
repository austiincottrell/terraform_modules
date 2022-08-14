##############
#### ROLE ####
##############

resource "aws_iam_role" "role" {
  count       = length(var.iam)
  name        = "${lookup(var.iam[count.index], "name")}-role" 
  description = "Role for ${lookup(var.iam[count.index], "name")}"

  assume_role_policy = lookup(var.iam[count.index], "role_policy")
}

################
#### POLICY ####
################

resource "aws_iam_policy" "policy" {
  count       = length(var.iam)
  name        = "${lookup(var.iam[count.index], "name")}-policy"
  description = "Policy for ${lookup(var.iam[count.index], "name")}"

  policy      = lookup(var.iam[count.index], "policy")
}

resource "aws_iam_policy_attachment" "attach" {
  count      = length(var.iam)
  name       = "${lookup(var.iam[count.index], "name")}-attach"
  roles      = [aws_iam_role.role[count.index].name]
  policy_arn = aws_iam_policy.policy[count.index].arn
}