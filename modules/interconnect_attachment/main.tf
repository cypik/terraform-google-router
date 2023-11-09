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

resource "google_compute_interconnect_attachment" "attachment" {
  name                     = format("%s-attachment", module.labels.id)
  edge_availability_domain = var.edge_availability_domain
  type                     = var.type
  router                   = var.router
  mtu                      = var.mtu
  project                  = data.google_client_config.current.project
  region                   = var.region
  admin_enabled            = var.admin_enabled
  description              = var.description
  bandwidth                = var.bandwidth
  candidate_subnets        = var.candidate_subnets
  vlan_tag8021q            = var.vlan_tag8021q

}

module "interface" {
  source   = "../interface"
  name     = var.interface.name
  router   = var.router
  region   = var.region
  ip_range = google_compute_interconnect_attachment.attachment.cloud_router_ip_address
  #  interconnect_attachment = google_compute_interconnect_attachment.attachment.self_link
  peers = [{
    name = var.peer.name

    peer_ip_address           = element(split("/", google_compute_interconnect_attachment.attachment.customer_router_ip_address), 1)
    peer_asn                  = var.peer.peer_asn
    advertised_route_priority = lookup(var.peer, "advertised_route_priority", null)
    bfd                       = lookup(var.peer, "bfd", null)
  }]
}