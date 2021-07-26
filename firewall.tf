# Allow SSH traffic to VMs
resource "google_compute_firewall" "allow-ssh" {
  name    = "${local.prefix}-allow-ssh"
  network = module.vpc.network_name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow traffic from everywhere to instances with an allow-ssh tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}
