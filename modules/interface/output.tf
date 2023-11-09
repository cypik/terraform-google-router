output "id" {
  value = join("", google_compute_router_interface.foobar[*].id)
}