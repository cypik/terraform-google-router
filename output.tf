output "router_id" {
  value       = join("", google_compute_router.router.*.id)
  description = "An identifier for the resource with format"
}

output "router_creation_timestamp" {
  value       = join("", google_compute_router.router.*.creation_timestamp)
  description = "Creation timestamp in RFC3339 text format."
}

output "router_self_link" {
  value       = join("", google_compute_router.router.*.self_link)
  description = "The URI of the created resource."
}

output "router" {
  value       = google_compute_router.router
  description = "Created Router"
}

output "nat" {
  value       = google_compute_router_nat.nats
  description = "Created NATs"
}