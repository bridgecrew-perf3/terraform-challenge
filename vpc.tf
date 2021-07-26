# https://github.com/terraform-google-modules/terraform-google-network
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = var.project
  network_name = "${local.prefix}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${local.prefix}-subnet-1"
      subnet_ip     = var.ea1_public_subnet
      subnet_region = var.region1_name
    },
    {
      subnet_name   = "${local.prefix}-subnet-2"
      subnet_ip     = var.we2_public_subnet
      subnet_region = var.region2_name
    },
    {
      subnet_name           = "${local.prefix}-subnet-3"
      subnet_ip             = var.ea1_private_subnet
      subnet_region         = var.region1_name
      subnet_private_access = "true"
    },
    {
      subnet_name           = "${local.prefix}-subnet-4"
      subnet_ip             = var.we2_private_subnet
      subnet_region         = var.region2_name
      subnet_private_access = "true"
    }
  ]

  routes = [
    {
      name              = "${local.prefix}-egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

# https://github.com/terraform-google-modules/terraform-google-cloud-router
module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "1.1.0"

  name    = "${local.prefix}-router"
  project = var.project
  region  = var.region1_name
  network = module.vpc.network_name
  nats = [
    {
      name                               = "${local.prefix}-nat"
      nat_ip_allocate_option             = "AUTO_ONLY"
      source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
      subnetworks = [
        {
          name                    = module.vpc.subnets["us-east1/${local.prefix}-subnet-1"].name
          source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
        },
        {
          name                    = module.vpc.subnets["us-east1/${local.prefix}-subnet-3"].name
          source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
        }
      ]
    }
  ]
}
