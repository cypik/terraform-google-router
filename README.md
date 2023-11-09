# terraform-gcp-router
# Google Cloud Infrastructure Provisioning with Terraform
## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [License](#license)

## Introduction
This project deploys a Google Cloud infrastructure using Terraform to create router .
## Usage
To use this module, you should have Terraform installed and configured for GCP. This module provides the necessary Terraform configuration for creating GCP resources, and you can customize the inputs as needed. Below is an example of how to use this module:
## Examples

# Example: nat
```hcl
module "cloud_router" {
  source      = "git::https://github.com/opz0/terraform-gcp-router.git?ref=v1.0.0"
  name        = "app"
  environment = "test"
  network     = module.vpc.vpc_id
  region      = "asia-northeast1"
  nats = [
    {
      name                               = "my-nat-gateway"
      source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    }
  ]
}
```
# Example: interconnect_attachment

```hcl
module "cloud_router" {
  source                          = "git::https://github.com/opz0/terraform-gcp-router.git?ref=v1.0.0"
  name                            = "app"
  environment                     = "test"
  region                          = "asia-northeast1"
  network                         = module.vpc.vpc_id
  enabled_interconnect_attachment = true

  bgp = {
    asn               = "16550"
    advertised_groups = ["ALL_SUBNETS"]
  }
}
```
# Example: default

```hcl
module "cloud_router" {
  source      = "git::https://github.com/opz0/terraform-gcp-router.git?ref=v1.0.0"
  name        = "app"
  environment = "test"
  region      = "asia-northeast1"
  network     = module.vpc.vpc_id
  bgp = {
    asn = "65001"
  }
}
```
This example demonstrates how to create various GCP resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs

- 'name'  :  Name of the NAT service.
- 'environment': The environment type.
- 'project_id' : The GCP project ID.
- 'region':  Region where the router and NAT reside.
- 'network': A reference to the network to which this router belongs.
- 'bgp' : BGP information specific to this router.
- 'nats' : RouterNat section in any Router for this network


## Module Outputs
Each module may have specific outputs. You can retrieve these outputs by referencing the module in your Terraform configuration.

- 'router_id' : An identifier for the resource with format.
- 'creation_timestamp' : Creation timestamp in RFC3339 text format.
- 'self_link':   The URI of the created resource.
- 'router' : Created Router.
- 'nat': Created NATs.

## Examples
For detailed examples on how to use this module, please refer to the 'examples' directory within this repository.

## Author
Your Name Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/opz0/terraform-gcp-router/blob/master/LICENSE) file for details.
