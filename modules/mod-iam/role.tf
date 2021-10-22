##############
#### ROLE ####
##############

# resource "aws_iam_role" "just_role" {
#   count       = length(var.role)
#   name        = "${lookup(var.role[count.index], "name", null)}-role" 
#   description = "Role for ${lookup(var.role[count.index], "name", null)}"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = "Assume Role"
#         Principal = {
#           Service = "${lookup(var.role[count.index], "service", null)}.amazonaws.com"
#         }
#       },
#     ]
#   })
# }