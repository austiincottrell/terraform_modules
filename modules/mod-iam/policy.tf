################
#### POLICY ####
################

# resource "aws_iam_policy" "just_policy" {
#   count       = length(var.policy)
#   name        = "${lookup(var.policy[count.index], "name", null)}-policy"
#   description = "Policy for ${lookup(var.policy[count.index], "name", null)}"

#   policy      = lookup(var.policy[count.index], "policy", null)
# }