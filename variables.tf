# ------------------------------------------
# Control Flow - IPV4
# ------------------------------------------
variable "configure_ipv4_firewall" {
  description = "Whether to configure the IPV4 Firewall or not"
  type        = bool
  default     = false
}
variable "create_ipv4_address_lists" {
  description = "Whether to create IPV4 Firewall Address lists or not"
  type        = bool
  default     = false
}
variable "create_ipv4_filter_rules" {
  description = "Whether to create IPV4 'flter' table Firewall rules or not"
  type        = bool
  default     = false
}
variable "create_ipv4_nat_rules" {
  description = "Whether to create IPV4 'nat' table Firewall rules or not"
  type        = bool
  default     = false
}
variable "create_ipv4_raw_rules" {
  description = "Whether to create IPV4 'raw' table Firewall rules or not"
  type        = bool
  default     = false
}
variable "create_ipv4_mangle_rules" {
  description = "Whether to create IPV4 'mangle' table Firewall rules or not"
  type        = bool
  default     = false
}

# ------------------------------------------
# Control Flow - IPV6
# ------------------------------------------
variable "configure_ipv6_firewall" {
  description = "Whether to configure the IPV6 Firewall or not"
  type        = bool
  default     = false
}
variable "create_ipv6_address_lists" {
  description = "Whether to create IPV6 Firewall Address lists or not"
  type        = bool
  default     = false
}
variable "create_ipv6_filter_rules" {
  description = "Whether to create IPV6 'flter' table Firewall rules or not"
  type        = bool
  default     = false
}
variable "create_ipv6_nat_rules" {
  description = "Whether to create IPV6 'nat' table Firewall rules or not"
  type        = bool
  default     = false
}
variable "create_ipv6_raw_rules" {
  description = "Whether to create IPV6 'raw' table Firewall rules or not"
  type        = bool
  default     = false
}
variable "create_ipv6_mangle_rules" {
  description = "Whether to create IPV6 'mangle' table Firewall rules or not"
  type        = bool
  default     = false
}

# ------------------------------------------
# Firewall Address Lists
# ------------------------------------------
variable "ipv4_address_list" {
  description = "List of IPV4 Firewall Address Lists"
  type = list(object({
    # Required
    address   = string
    list_name = string

    # Optional
    disabled = optional(bool, false)
    comment  = optional(string)
    timeout  = optional(string)
  }))
  default = [
    {
      address   = "224.0.0.0/4"
      list_name = "AL_BL_NoForwardIPV4"
      comment   = "multicast|DAL4"
    },
    {
      address   = "255.255.255.255"
      list_name = "AL_BL_NoForwardIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "127.0.0.0/8"
      list_name = "AL_BL_BadIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "192.0.0.0/24"
      list_name = "AL_BL_BadIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "192.0.2.0/24"
      list_name = "AL_BL_BadIPV4"
      comment   = "RFC6890 documentation|DAL4"
    },
    {
      address   = "198.51.100.0/24"
      list_name = "AL_BL_BadIPV4"
      comment   = "RFC6890 documentation|DAL4"
    },
    {
      address   = "203.0.113.0/24"
      list_name = "AL_BL_BadIPV4"
      comment   = "RFC6890 documentation|DAL4"
    },
    {
      address   = "240.0.0.0/4"
      list_name = "AL_BL_BadIPV4"
      comment   = "RFC6890 reserved|DAL4"
    },
    {
      address   = "0.0.0.0/8"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "10.0.0.0/8"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "100.64.0.0/10"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "169.254.0.0/16"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "172.16.0.0/12"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "192.0.0.0/29"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "192.168.0.0/16"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "198.18.0.0/15"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890 benchmark|DAL4"
    },
    {
      address   = "255.255.255.255"
      list_name = "AL_BL_NotGlobalIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "224.0.0.0/4"
      list_name = "AL_BL_BadSrcIPV4"
      comment   = "multicast"
    },
    {
      address   = "255.255.255.255"
      list_name = "AL_BL_BadSrcIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "0.0.0.0/8"
      list_name = "AL_BL_BadDstIPV4"
      comment   = "RFC6890|DAL4"
    },
    {
      address   = "224.0.0.0/4"
      list_name = "AL_BL_BadDstIPV4"
      comment   = "RFC6890|DAL4"
    }
  ]
}
variable "ipv6_address_list" {
  description = "List of IPV6 Firewall Address Lists"
  type = list(object({
    # Required
    address   = string
    list_name = string

    # Optional
    disabled = optional(bool, false)
    comment  = optional(string)
    timeout  = optional(string)
  }))
  default = [
    {
      address   = "::1/128"
      list_name = "AL_BL_BadIPV6"
      comment   = "RFC6890 lo|DAL6"
    },
    {
      address   = "::ffff:0:0/96"
      list_name = "AL_BL_BadIPV6"
      comment   = "RFC6890 IPv4 mapped|DAL6"
    },
    {
      address   = "2001::/23"
      list_name = "AL_BL_BadIPV6"
      comment   = "RFC6890|DAL6"
    },
    {
      address   = "2001:db8::/32"
      list_name = "AL_BL_BadIPV6"
      comment   = "RFC6890 documentation|DAL6"
    },
    {
      address   = "2001:10::/28"
      list_name = "AL_BL_BadIPV6"
      comment   = "RFC6890 orchid|DAL6"
    },
    {
      address   = "::/96"
      list_name = "AL_BL_BadIPV6"
      comment   = "ipv4 compat|DAL6"
    },
    {
      address   = "100::/64"
      list_name = "AL_BL_NotGlobalIPV6"
      comment   = "RFC6890 Discard-only|DAL6"
    },
    {
      address   = "2001::/32"
      list_name = "AL_BL_NotGlobalIPV6"
      comment   = "RFC6890 TEREDO|DAL6"
    },
    {
      address   = "2001:2::/48"
      list_name = "AL_BL_NotGlobalIPV6"
      comment   = "RFC6890 Benchmark|DAL6"
    },
    {
      address   = "fc00::/7"
      list_name = "AL_BL_NotGlobalIPV6"
      comment   = "RFC6890 Unique-Local|DAL6"
    },
    {
      address   = "::/128"
      list_name = "AL_BL_BadDstIPV6"
      comment   = "unspecified|DAL6"
    },
    {
      address   = "::/128"
      list_name = "AL_BL_BadSrcIPV6"
      comment   = "unspecified|DAL6"
    },
    {
      address   = "ff00::/8"
      list_name = "AL_BL_BadSrcIPV6"
      comment   = "multicast|DAL6"
    }
  ]
}

# ------------------------------------------
# IPV4 'FILTER' Table Rules
# ------------------------------------------
variable "ipv4_filter_rules" {
  description = "List of IPv4 firewall filter rules"
  type = list(object({
    # Required
    action = string
    chain  = string

    # Optional
    disabled                  = optional(bool, false)
    log                       = optional(bool, false)
    fragment                  = optional(bool)
    hw_offload                = optional(bool)
    random                    = optional(number)
    dscp                      = optional(number)
    ingress_priority          = optional(number)
    priority                  = optional(number)
    address_list              = optional(string)
    address_list_timeout      = optional(string)
    comment                   = optional(string)
    connection_bytes          = optional(string)
    connection_limit          = optional(string)
    connection_mark           = optional(string)
    connection_nat_state      = optional(string)
    connection_rate           = optional(string)
    connection_state          = optional(string)
    connection_type           = optional(string)
    content                   = optional(string)
    dst_address               = optional(string)
    dst_address_list          = optional(string)
    dst_address_type          = optional(string)
    dst_limit                 = optional(string)
    dst_port                  = optional(string)
    hotspot                   = optional(string)
    icmp_options              = optional(string)
    in_bridge_port            = optional(string)
    in_bridge_port_list       = optional(string)
    in_interface              = optional(string)
    in_interface_list         = optional(string)
    ipsec_policy              = optional(string)
    ipv4_options              = optional(string)
    jump_target               = optional(string)
    layer7_protocol           = optional(string)
    limit                     = optional(string)
    log_prefix                = optional(string)
    nth                       = optional(string)
    out_bridge_port           = optional(string)
    out_bridge_port_list      = optional(string)
    out_interface             = optional(string)
    out_interface_list        = optional(string)
    packet_mark               = optional(string)
    packet_size               = optional(string)
    per_connection_classifier = optional(string)
    place_before              = optional(string)
    port                      = optional(string)
    protocol                  = optional(string)
    psd                       = optional(string)
    reject_with               = optional(string)
    routing_mark              = optional(string)
    routing_table             = optional(string)
    src_address               = optional(string)
    src_address_list          = optional(string)
    src_address_type          = optional(string)
    src_mac_address           = optional(string)
    src_port                  = optional(string)
    tcp_flags                 = optional(string)
    tcp_mss                   = optional(string)
    time                      = optional(string)
    tls_host                  = optional(string)
    ttl                       = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for rule in var.ipv4_filter_rules : contains(
        ["accept", "drop", "reject", "fasttrack-connection", "jump", "return", "log", "tarpit",
        "add-src-to-address-list", "add-dst-to-address-list"],
        rule.action
      )
    ])
    error_message = "ipv4_filter_rules[*].action must be one of: accept, drop, reject, fasttrack-connection, jump, return, log, tarpit, add-src-to-address-list, add-dst-to-address-list"
  }
  validation {
    condition = alltrue([
      for rule in var.ipv4_filter_rules : rule.jump_target == null || rule.action == "jump"
    ])
    error_message = "jump_target may only be set when action == 'jump'"
  }
  validation {
    condition = alltrue([
      for rule in var.ipv4_filter_rules : rule.log_prefix == null || length(rule.log_prefix) <= 31
    ])
    error_message = "log_prefix can't be longer than 31 characters (RouterOS limitation)"
  }
  validation {
    condition = alltrue([
      for rule in var.ipv4_filter_rules : rule.src_address_list == null || rule.dst_address_list == null
    ])
    error_message = "A rule cannot have both src_address_list and dst_address_list set at the same time"
  }
}

# ------------------------------------------
# IPV4 'NAT' Table Rules
# ------------------------------------------
variable "ipv4_nat_rules" {
  description = "List of IPv4 NAT rules to create"
  type = list(object({
    # Required
    action = string
    chain  = string

    # Optional
    disabled                  = optional(bool, false)
    log                       = optional(bool, false)
    fragment                  = optional(bool)
    randomise_ports           = optional(bool)
    same_not_by_dst           = optional(bool)
    socks5_port               = optional(number)
    ingress_priority          = optional(number)
    dscp                      = optional(number)
    priority                  = optional(number)
    random                    = optional(number)
    address_list              = optional(string)
    address_list_timeout      = optional(string)
    comment                   = optional(string)
    connection_bytes          = optional(string)
    connection_limit          = optional(string)
    connection_mark           = optional(string)
    connection_rate           = optional(string)
    connection_type           = optional(string)
    content                   = optional(string)
    dst_address               = optional(string)
    dst_address_list          = optional(string)
    dst_address_type          = optional(string)
    dst_limit                 = optional(string)
    dst_port                  = optional(string)
    hotspot                   = optional(string)
    icmp_options              = optional(string)
    in_bridge_port            = optional(string)
    in_bridge_port_list       = optional(string)
    in_interface              = optional(string)
    in_interface_list         = optional(string)
    ipsec_policy              = optional(string)
    ipv4_options              = optional(string)
    jump_target               = optional(string)
    layer7_protocol           = optional(string)
    limit                     = optional(string)
    log_prefix                = optional(string)
    nth                       = optional(string)
    out_bridge_port           = optional(string)
    out_bridge_port_list      = optional(string)
    out_interface             = optional(string)
    out_interface_list        = optional(string)
    packet_mark               = optional(string)
    packet_size               = optional(string)
    per_connection_classifier = optional(string)
    place_before              = optional(string)
    port                      = optional(string)
    protocol                  = optional(string)
    psd                       = optional(string)
    routing_mark              = optional(string)
    socks5_server             = optional(string)
    socksify_service          = optional(string)
    src_address               = optional(string)
    src_address_list          = optional(string)
    src_address_type          = optional(string)
    src_mac_address           = optional(string)
    src_port                  = optional(string)
    tcp_mss                   = optional(string)
    time                      = optional(string)
    to_addresses              = optional(string)
    to_ports                  = optional(string)
    ttl                       = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.ipv4_nat_rules : contains(
        ["masquerade", "srcnat", "dstnat", "netmap", "redirect", "same"], r.action
      )
    ])
    error_message = "Each NAT rule 'action' must be one of: masquerade, srcnat, dstnat, netmap, redirect, same"
  }
}

# ------------------------------------------
# IPV4 'RAW' Table Rules
# ------------------------------------------
variable "ipv4_raw_rules" {
  description = "List of IPv4 firewall raw rules"
  type = list(object({
    # Required
    action = string
    chain  = string

    # Optional
    disabled                  = optional(bool, false)
    log                       = optional(bool, false)
    fragment                  = optional(bool)
    dscp                      = optional(number)
    ingress_priority          = optional(number)
    priority                  = optional(number)
    random                    = optional(number)
    address_list              = optional(string)
    address_list_timeout      = optional(string)
    comment                   = optional(string)
    content                   = optional(string)
    dst_address               = optional(string)
    dst_address_list          = optional(string)
    dst_address_type          = optional(string)
    dst_limit                 = optional(string)
    dst_port                  = optional(string)
    hotspot                   = optional(string)
    icmp_options              = optional(string)
    in_bridge_port            = optional(string)
    in_bridge_port_list       = optional(string)
    in_interface              = optional(string)
    in_interface_list         = optional(string)
    ipsec_policy              = optional(string)
    ipv4_options              = optional(string)
    jump_target               = optional(string)
    limit                     = optional(string)
    log_prefix                = optional(string)
    nth                       = optional(string)
    out_bridge_port           = optional(string)
    out_bridge_port_list      = optional(string)
    out_interface             = optional(string)
    out_interface_list        = optional(string)
    packet_mark               = optional(string)
    packet_size               = optional(string)
    per_connection_classifier = optional(string)
    place_before              = optional(string)
    port                      = optional(string)
    protocol                  = optional(string)
    psd                       = optional(string)
    src_address               = optional(string)
    src_address_list          = optional(string)
    src_address_type          = optional(string)
    src_mac_address           = optional(string)
    src_port                  = optional(string)
    tcp_flags                 = optional(string)
    tcp_mss                   = optional(string)
    time                      = optional(string)
    tls_host                  = optional(string)
    ttl                       = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.ipv4_raw_rules : contains(
        ["accept", "drop", "add-src-to-address-list", "add-dst-to-address-list", "jump", "log"], r.action
      )
    ])
    error_message = "Each raw firewall rule 'action' must be one of: accept, drop, add-src-to-address-list, add-dst-to-address-list, jump, log"
  }
}

# ------------------------------------------
# IPV4 'MANGLE' Table Rules
# ------------------------------------------
variable "ipv4_mangle_rules" {
  description = "List of IPv4 firewall mangle rules"
  type = list(object({
    # Required
    action = string
    chain  = string

    # Optional
    disabled                  = optional(bool, false)
    log                       = optional(bool, false)
    passthrough               = optional(bool)
    fragment                  = optional(bool)
    ingress_priority          = optional(number)
    new_dscp                  = optional(number)
    random                    = optional(number)
    dscp                      = optional(number)
    address_list              = optional(string)
    address_list_timeout      = optional(string)
    comment                   = optional(string)
    connection_bytes          = optional(string)
    connection_limit          = optional(string)
    connection_mark           = optional(string)
    connection_nat_state      = optional(string)
    connection_rate           = optional(string)
    connection_state          = optional(string)
    connection_type           = optional(string)
    content                   = optional(string)
    dst_address               = optional(string)
    dst_address_list          = optional(string)
    dst_address_type          = optional(string)
    dst_limit                 = optional(string)
    dst_port                  = optional(string)
    hotspot                   = optional(string)
    icmp_options              = optional(string)
    in_bridge_port            = optional(string)
    in_bridge_port_list       = optional(string)
    in_interface              = optional(string)
    in_interface_list         = optional(string)
    ipsec_policy              = optional(string)
    ipv4_options              = optional(string)
    jump_target               = optional(string)
    layer7_protocol           = optional(string)
    limit                     = optional(string)
    log_prefix                = optional(string)
    new_connection_mark       = optional(string)
    new_mss                   = optional(string)
    new_packet_mark           = optional(string)
    new_priority              = optional(string)
    new_routing_mark          = optional(string)
    new_ttl                   = optional(string)
    nth                       = optional(string)
    out_bridge_port           = optional(string)
    out_bridge_port_list      = optional(string)
    out_interface             = optional(string)
    out_interface_list        = optional(string)
    packet_mark               = optional(string)
    packet_size               = optional(string)
    per_connection_classifier = optional(string)
    place_before              = optional(string)
    port                      = optional(string)
    protocol                  = optional(string)
    psd                       = optional(string)
    route_dst                 = optional(string)
    routing_mark              = optional(string)
    src_address               = optional(string)
    src_address_list          = optional(string)
    src_address_type          = optional(string)
    src_mac_address           = optional(string)
    src_port                  = optional(string)
    tcp_flags                 = optional(string)
    tcp_mss                   = optional(string)
    time                      = optional(string)
    tls_host                  = optional(string)
    ttl                       = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.ipv4_mangle_rules : contains(
        ["change-mss", "mark-connection", "mark-packet", "mark-routing", "log", "add-src-to-address-list", "add-dst-to-address-list", "jump", "passthrough"], r.action
      )
    ])
    error_message = "Each mangle rule 'action' must be one of: change-mss, mark-connection, mark-packet, mark-routing, log, add-src-to-address-list, add-dst-to-address-list, jump, passthrough"
  }
}