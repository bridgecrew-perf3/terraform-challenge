variable "company" {
  type    = string
  default = "acme"
}

variable "env" {
  type    = string
  default = "dev"
}

# GCP

variable "project" {
  type        = string
  description = "The host project ID"
}

variable "gcp_sa_key" {
  type        = string
  description = "The path to service account key"
}

variable "region1_name" {
  type    = string
  default = "us-east1"
}

variable "region1_zone" {
  type    = string
  default = "us-east1-b"
}

variable "region2_name" {
  type    = string
  default = "us-west2"
}

variable "region2_zone" {
  type    = string
  default = "us-west2-b"
}

# VPC

variable "ea1_public_subnet" {
  type    = string
  default = "10.0.0.0/24"
}

variable "we2_public_subnet" {
  type    = string
  default = "10.0.1.0/24"
}

variable "ea1_private_subnet" {
  type    = string
  default = "10.0.2.0/24"
}

variable "we2_private_subnet" {
  type    = string
  default = "10.0.3.0/24"
}

# VM

variable "redhat_machine_type" {
  type    = string
  default = "e2-medium"
}

variable "redhat_disk_size" {
  type    = number
  default = 20
}

variable "redhat_image" {
  type    = string
  default = "rhel-8-v20210721"
}

variable "ssh_user" {
  type        = string
  description = "The ssh user name"
}

variable "ssh_key" {
  type        = string
  description = "The path to the SSH key"
}
