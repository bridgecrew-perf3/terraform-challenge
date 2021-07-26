output "vm-ssh-ip" {
  value = google_compute_instance.instance-ssh.network_interface[0].access_config[0].nat_ip
}

output "lb-ip" {
  value = module.gce-lb-http.external_ip
}
