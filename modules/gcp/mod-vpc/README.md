# GCP VPC Network

Use cases: 

1) Regular 1 to 1 VPC and Subnet deployment

2) Wanting to deploy the same vcp to different regions/projects

Example: 

locals {
  network_names = ["test-vpc"]
  project_ids   = ["<PROJECT_ID>"]
}

module "vpc" {
  source      = "./terraform_modules/modules/gcp/mod-vpc"
  network     = [
    {
      name          = local.network_names[0]
      project_id    = local.project_ids[0]
      routing_mode  = "REGIONAL" # REGIONAL or GLOBAL
      public_access = false      # false will make the network private w/o 0.0.0.0 route 
    }
  ]
  subnets     = [
    {
        network_name          = local.network_names[0]
        project_id            = local.project_ids[0]
        subnet_name           = "subnet-01"
        subnet_ip             = "10.10.10.0/24"
        subnet_region         = "us-west1"
    },
    {
        network_name          = local.network_names[0]
        project_id            = local.project_ids[0]
        subnet_name           = "subnet-02"
        subnet_ip             = "10.10.20.0/24"
        subnet_region         = "us-west1"
        subnet_private_access = "true"
        subnet_flow_logs      = "true"
        description           = "This subnet has a description"
    },
    {
        network_name                 = local.network_names[0]
        project_id                   = local.project_ids[0]
        subnet_name                  = "subnet-03"
        subnet_ip                    = "10.10.30.0/24"
        subnet_region                = "us-west1"
        subnet_flow_logs             = "true"
        subnet_flow_logs_interval    = "INTERVAL_10_MIN"
        subnet_flow_logs_sampling    = 0.7
        subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
        subnet_flow_logs_filter_expr = "true"
    }
  ]
  secondary_ranges = {
    subnet-01 = [
        {
            range_name    = "subnet-01-secondary-01"
            ip_cidr_range = "192.168.64.0/24"
        },
    ]

    subnet-02 = []
  }
}