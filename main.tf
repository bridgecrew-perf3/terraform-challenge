terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.76.0"
    }
  }
}

provider "google" {
  alias       = "east"
  credentials = file(var.gcp_sa_key)

  project = var.project
  region  = var.region1_name
  zone    = var.region1_zone
}

locals {
  prefix = "${var.company}-${var.env}"
}
