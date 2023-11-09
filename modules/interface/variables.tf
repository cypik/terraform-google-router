variable "name" {
  type        = string
  default     = ""
  description = "Name of the resource. Provided by the client when the resource is created. "
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = ""
  description = "ManagedBy, eg 'Opz0'."
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}

variable "router" {
  type        = string
  default     = ""
  description = "Name of the router the interface resides"
}

variable "region" {
  type        = string
  default     = ""
  description = "Region where the interface resides"
}

variable "ip_range" {
  type        = string
  description = "IP address and range of the interface"
  default     = null
}

variable "vpn_tunnel" {
  type        = string
  description = "The name or resource link to the VPN tunnel this interface will be linked to"
  default     = null
}

variable "peers" {
  type = list(object({
    name                      = string
    peer_ip_address           = string
    peer_asn                  = string
    advertised_route_priority = optional(number)
    bfd = object({
      session_initialization_mode = string
      min_transmit_interval       = optional(number)
      min_receive_interval        = optional(number)
      multiplier                  = optional(number)
    })
  }))
  description = "BGP peers for this interface."
  default     = []
}

variable "peer_asn" {
  type    = number
  default = 65513
}