resource "google_compute_router_interface" "foobar" {
  name       = var.name
  router     = var.router
  region     = var.region
  ip_range   = var.ip_range
  vpn_tunnel = var.vpn_tunnel
  project    = var.project
  #  interconnect_attachment = var.vpn_tunnel

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
