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
#### router module call.
####==============================================================================
module "cloud_router" {
  source     = "../../"
  name       = "my-router"
  region     = "asia-northeast1"
  project_id = "opz0-397319"
  network    = module.vpc.vpc_id
  bgp = {
    asn = "65001"
  }
}