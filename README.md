# Terraform Modules
<h2><br> 
Built on Terraform v1.0.3</h2>

<p>Calling a module

    module "iam" {
      source = "./modules/mod-iam"
      # role   = [{}] # Create only a role
      # policy = [{}] # Create only a policy
      iam    = [
        ### Lambda Role/Policy ###
        {
          name    = "Lambda"
          role_policy = file("policy/lambda-role.json")
          policy  = jsonencode({
            Version = "2012-10-17",
            Statement = [
              {
                Effect = "Allow",
                Action = [
                  "ses:SendEmail",
                  "ses:SendRawEmail"
                ],
                Resource = "arn:aws:ses:${local.region}:${local.account_number}:identity/${local.domainName}"
              }
            ]
          })
        },
      ]
    }

When you call a module check the var.tf inside the module for what variables need to be called inside the terrafrom module.

If sections of terraform is commented out please note that this was done for my implementation and to allow others to use it the way they want to implement the terraform.</p>

When calling a module that has resources you may not use change the count value from 

  length(var.event_step) > 0 ? length(var.event_step) : 0

to

  length(var.event_step) > 1 ? length(var.event_step) : 0

This will allow you to skip calling the unwanted resource in your code. Once you do want to use this resource simple revert back to 0.