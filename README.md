# terraform_modules
Terraform Modules 

<h2>Built on Terraform v1.0.3 <h2>

<p>Calling a module<p>

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

<h3>When you call a module check the var.tf inside the module for what variables need to be called inside the terrafrom module.<h3>

<h3>If sections of terraform is commented out please note that this was done for my implementation and to allow others to use it the way they want to implement the terraform.<h3>