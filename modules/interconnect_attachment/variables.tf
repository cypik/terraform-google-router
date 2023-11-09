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
  description = "Name of the router the attachment resides"
}

variable "region" {
  type        = string
  default     = ""
  description = "Region where the attachment resides"
}

variable "admin_enabled" {
  type        = bool
  description = "Whether the VLAN attachment is enabled or disabled"
  default     = true
}

variable "type" {
  type        = string
  description = "The type of InterconnectAttachment you wish to create"
  default     = "PARTNER"
}

variable "bandwidth" {
  type        = string
  description = "Provisioned bandwidth capacity for the interconnect attachment"
  default     = ""
}

variable "mtu" {
  type        = string
  description = "Maximum Transmission Unit (MTU), in bytes, of packets passing through this interconnect attachment. Currently, only 1440 and 1500 are allowed. If not specified, the value will default to 1440."
  default     = 1500
}

variable "description" {
  type        = string
  description = "An optional description of this resource"
  default     = null
}

variable "candidate_subnets" {
  type        = list(string)
  description = "Up to 16 candidate prefixes that can be used to restrict the allocation of cloudRouterIpAddress and customerRouterIpAddress for this attachment. All prefixes must be within link-local address space (169.254.0.0/16) and must be /29 or shorter (/28, /27, etc)."
  default     = null
}

variable "vlan_tag8021q" {
  type        = string
  description = "The IEEE 802.1Q VLAN tag for this attachment, in the range 2-4094."
  default     = null
}

variable "interface" {
  description = "Interface to deploy for this attachment."
  type = object({
    name = string
  })
}

variable "peer" {
  description = "BGP Peer for this attachment."
  type = object({
    name                      = string
    peer_asn                  = string
    advertised_route_priority = optional(number)
    bfd = optional(object({
      session_initialization_mode = string
      min_transmit_interval       = optional(number)
      min_receive_interval        = optional(number)
      multiplier                  = optional(number)
    }))
  })
}
variable "edge_availability_domain" {
  type    = string
  default = "AVAILABILITY_DOMAIN_1"
}