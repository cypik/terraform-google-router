provider "google" {
  project = "opz0-397319"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

####==============================================================================
#### vpc module call.
####==============================================================================
module "vpc" {
  source                                    = "git::git@github.com:opz0/terraform-gcp-vpc.git?ref=master"
  name                                      = "app"
  environment                               = "test"
  label_order                               = ["name", "environment"]
  project_id                                = "opz0-397319"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

####==============================================================================
#### cloud_router module call.
####==============================================================================
module "cloud_router" {
  source     = "../../"
  name       = "example-router"
  project_id = "opz0-397319"
  network    = module.vpc.vpc_id
  region     = "asia-northeast1"

  bgp = {
    asn               = "16550"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

####==============================================================================
#### interconnect_attachment module call.
####==============================================================================
module "interconnect_attachment" {
  source       = "../../modules/interconnect_attachment"
  name         = "test-suresh"
  project      = "opz0-397319"
  region       = "asia-northeast1"
  router       = module.cloud_router.router.name
  interconnect = "https://googleapis.com/interconnects/example-interconnect"

  interface = {
    name = "interface"
  }

  peer = {
    name            = "peer"
    peer_ip_address = "192.0.2.1"
    peer_asn        = "16550"
  }
}