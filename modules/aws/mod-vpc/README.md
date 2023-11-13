# mod-vpc

Calling module

```hcl
module "vpc" {
  source = "git::ssh://git@github.com/austiincottrell/terraform_modules.git//modules/aws/mod-vpc/?ref=master"

  name = "vpc-name"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

Update variables as needed and you are good to run terraform plan then apply.