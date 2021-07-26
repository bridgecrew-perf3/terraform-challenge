resource "google_compute_instance" "instance-ssh" {
  provider     = google.east
  name         = "${local.prefix}-instance-ssh"
  machine_type = var.redhat_machine_type
  zone         = var.region1_zone

  boot_disk {
    initialize_params {
      size  = var.redhat_disk_size
      image = var.redhat_image
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_key)}"
  }

  network_interface {
    network    = module.vpc.network_name
    subnetwork = module.vpc.subnets["us-east1/${local.prefix}-subnet-1"].name
    access_config {
    }
  }

  tags = ["allow-ssh"]
}

resource "google_compute_instance" "instance-http" {
  provider     = google.east
  name         = "${local.prefix}-instance-http"
  machine_type = var.redhat_machine_type
  zone         = var.region1_zone

  boot_disk {
    initialize_params {
      size  = var.redhat_disk_size
      image = var.redhat_image
    }
  }

  metadata = {
    ssh-keys       = "${var.ssh_user}:${file(var.ssh_key)}"
    startup-script = file("install-apache.sh")
  }

  network_interface {
    network    = module.vpc.network_name
    subnetwork = module.vpc.subnets["us-east1/${local.prefix}-subnet-3"].name
  }

  tags = ["allow-http"]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group
resource "google_compute_instance_group" "webservers" {
  provider = google.east
  name     = "${local.prefix}-instance-group-http"
  instances = [
    google_compute_instance.instance-http.id
  ]

  named_port {
    name = "http"
    port = "80"
  }

  zone = var.region1_zone
}
