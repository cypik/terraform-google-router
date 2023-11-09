module "labels" {
  source      = "git::https://github.com/opz0/terraform-gcp-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
}

data "google_client_config" "current" {
}

resource "google_compute_router_interface" "foobar" {
  name       = format("%s-foobar", module.labels.id)
  router     = var.router
  region     = var.region
  ip_range   = var.ip_range
  vpn_tunnel = var.vpn_tunnel
  project    = data.google_client_config.current.project

}
resource "google_compute_router_peer" "peer" {
  for_each = {
    for p in var.peers :
    p.name => p
  }

  name                      = "test-app"
  project                   = google_compute_router_interface.foobar.project
  router                    = google_compute_router_interface.foobar.router
  region                    = google_compute_router_interface.foobar.region
  peer_ip_address           = each.value.peer_ip_address
  peer_asn                  = var.peer_asn
  advertised_route_priority = lookup(each.value, "advertised_route_priority", null)
  interface                 = google_compute_router_interface.foobar.name
  dynamic "bfd" {
    for_each = lookup(each.value, "bfd", null) == null ? [] : [""]
    content {
      session_initialization_mode = try(each.value.bfd.session_initialization_mode, null)
      min_receive_interval        = try(each.value.bfd.min_receive_interval, null)
      min_transmit_interval       = try(each.value.bfd.min_transmit_interval, null)
      multiplier                  = try(each.value.bfd.multiplier, null)
    }
  }
}