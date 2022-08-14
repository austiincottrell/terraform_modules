resource "google_compute_network" "network" {
  
  description                     = var.description

  count                           = length(var.network)
  name                            = lookup(var.network[count.index], "name")
  project                         = lookup(var.network[count.index], "project_id")
  auto_create_subnetworks         = length(var.subnets) > 0 ? false : true
  routing_mode                    = lookup(var.network[count.index], "routing_mode", "REGIONAL")
  delete_default_routes_on_create = lookup(var.network[count.index], "public_access", false) == false ? true : false
  mtu                             = lookup(var.network[count.index], "mtu", 1460)
}

# resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
#   provider = google-beta

#   count      = var.shared_vpc_host ? 1 : 0
#   project    = var.project_id
#   depends_on = [google_compute_network.network]
# }