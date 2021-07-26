# Terraform Challenge

## Network Diagram

![Alt text](/gcp-network-diagram.jpeg "GCP Network Diagram")

## Prerequisites

* Terraform CLI
* 2 GCP projects with Compute Engine API enabled
* Service Account with appropriate permissions and key for each project
* SSH key pair

## Sample `terraform.tfvars`

Below is an example file for Terraform variables required to run:

```
project    = "your-project-id"
gcp_sa_key = "~/path/to/key.json"
ssh_user   = "username-for-ssh"
ssh_key    = "~/path/to/public/ssh/key.pub"
```

## Design Decisions

* Deployed public/private subnet pair in 2 regions for high availability.
* Used `e2-medium` machine type for cost-optimation and to meet [RHEL system requirements](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_a_standard_rhel_installation/system-requirements-reference_installing-rhel#check-disk-and-memory-requirements_system-requirements-reference).
* Deployed Cloud Router and NAT so instances in the private subnet can connect to outside of the VPC.
* Utilized Unmanaged Instance Group as there was only one VM to balance traffic across.
* Deployed HTTP Load Balancer which utilizes IG as a backend with a health check at `/` on port `80`.
* Configured Firewall Rule to target public instance for SSH traffic on port `22`.
* Created variables and defaults in `variables.tf`.
* Created outputs for public IPs in `outputs.tf`.

## Resources Used

* https://medium.com/slalom-technology/a-complete-gcp-environment-with-terraform-c087190366f0
* https://www.youtube.com/watch?v=ee6GxAev1Pk
* https://access.redhat.com/documentation/en-us/jboss_enterprise_application_platform/6.3/html/administration_and_configuration_guide/install_the_apache_httpd_in_red_hat_enterprise_linux_with_jboss_eap_6_rpm
* Terraform & GitHub documentation for modules used

## To Do

* Project & Folder structure for Shared VPC among host and service.
    * Use `google_compute_shared_vpc_host_project` and `google_compute_shared_vpc_service_project` resources to share VPC.
    * Need to setup Organization with Google Workspace or Cloud Identity.
    * Configure IAM.

## Known Issues

N/A
