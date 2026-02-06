# ------------------------------------------
# IPV4 'FILTER' Table Rules
# ------------------------------------------
resource "routeros_ip_firewall_filter" "ipv4_filter_rules" {
  for_each   = var.configure_ipv4_firewall && var.create_ipv4_filter_rules ? local.ipv4_filter_rules_indexed_map : {}
  depends_on = [routeros_ip_firewall_addr_list.ipv4_address_list]

  # Required
  chain  = each.value.chain
  action = each.value.action

  # Optional
  comment                   = lookup(each.value, "comment", null)
  disabled                  = lookup(each.value, "disabled", false)
  address_list              = lookup(each.value, "address_list", null)
  address_list_timeout      = lookup(each.value, "address_list_timeout", null)
  connection_bytes          = lookup(each.value, "connection_bytes", null)
  connection_limit          = lookup(each.value, "connection_limit", null)
  connection_mark           = lookup(each.value, "connection_mark", null)
  connection_nat_state      = lookup(each.value, "connection_nat_state", null)
  connection_rate           = lookup(each.value, "connection_rate", null)
  connection_state          = lookup(each.value, "connection_state", null)
  connection_type           = lookup(each.value, "connection_type", null)
  content                   = lookup(each.value, "content", null)
  dst_address               = lookup(each.value, "dst_address", null)
  dst_address_list          = lookup(each.value, "dst_address_list", null)
  dst_address_type          = lookup(each.value, "dst_address_type", null)
  dst_limit                 = lookup(each.value, "dst_limit", null)
  dst_port                  = lookup(each.value, "dst_port", null)
  fragment                  = lookup(each.value, "fragment", null)
  hotspot                   = lookup(each.value, "hotspot", null)
  hw_offload                = lookup(each.value, "hw_offload", null)
  icmp_options              = lookup(each.value, "icmp_options", null)
  in_bridge_port            = lookup(each.value, "in_bridge_port", null)
  in_bridge_port_list       = lookup(each.value, "in_bridge_port_list", null)
  in_interface              = lookup(each.value, "in_interface", null)
  in_interface_list         = lookup(each.value, "in_interface_list", null)
  ingress_priority          = lookup(each.value, "ingress_priority", null)
  ipsec_policy              = lookup(each.value, "ipsec_policy", null)
  ipv4_options              = lookup(each.value, "ipv4_options", null)
  jump_target               = lookup(each.value, "jump_target", null)
  layer7_protocol           = lookup(each.value, "layer7_protocol", null)
  limit                     = lookup(each.value, "limit", null)
  log                       = lookup(each.value, "log", false)
  log_prefix                = lookup(each.value, "log_prefix", null)
  nth                       = lookup(each.value, "nth", null)
  out_bridge_port           = lookup(each.value, "out_bridge_port", null)
  out_bridge_port_list      = lookup(each.value, "out_bridge_port_list", null)
  out_interface             = lookup(each.value, "out_interface", null)
  out_interface_list        = lookup(each.value, "out_interface_list", null)
  packet_mark               = lookup(each.value, "packet_mark", null)
  packet_size               = lookup(each.value, "packet_size", null)
  per_connection_classifier = lookup(each.value, "per_connection_classifier", null)
  place_before              = lookup(each.value, "place_before", null)
  port                      = lookup(each.value, "port", null)
  protocol                  = lookup(each.value, "protocol", null)
  psd                       = lookup(each.value, "psd", null)
  random                    = lookup(each.value, "random", null)
  reject_with               = lookup(each.value, "reject_with", null)
  routing_mark              = lookup(each.value, "routing_mark", null)
  routing_table             = lookup(each.value, "routing_table", null)
  src_address               = lookup(each.value, "src_address", null)
  src_address_list          = lookup(each.value, "src_address_list", null)
  src_address_type          = lookup(each.value, "src_address_type", null)
  src_mac_address           = lookup(each.value, "src_mac_address", null)
  src_port                  = lookup(each.value, "src_port", null)
  tcp_flags                 = lookup(each.value, "tcp_flags", null)
  tcp_mss                   = lookup(each.value, "tcp_mss", null)
  time                      = lookup(each.value, "time", null)
  tls_host                  = lookup(each.value, "tls_host", null)
  ttl                       = lookup(each.value, "ttl", null)

  lifecycle {
    create_before_destroy = true
  }
}
# Sort 'FILTER' rules
resource "routeros_move_items" "ipv4_filter_rules" {
  count = var.configure_ipv4_firewall && var.create_ipv4_filter_rules ? 1 : 0

  resource_path = "/ip/firewall/filter"
  sequence      = [for i, _ in local.ipv4_filter_rules_indexed_map : routeros_ip_firewall_filter.ipv4_filter_rules[i].id]
  depends_on    = [routeros_ip_firewall_filter.ipv4_filter_rules]
}

# ------------------------------------------
# IPV4 'NAT' Table Rules
# ------------------------------------------
resource "routeros_ip_firewall_nat" "ipv4_nat_rules" {
  for_each   = var.configure_ipv4_firewall && var.create_ipv4_nat_rules ? local.ipv4_nat_rules_indexed_map : {}
  depends_on = [routeros_ip_firewall_addr_list.ipv4_address_list]

  # Required
  action = each.value.action
  chain  = each.value.chain

  # Optional
  address_list              = lookup(each.value, "address_list", null)
  address_list_timeout      = lookup(each.value, "address_list_timeout", null)
  comment                   = lookup(each.value, "comment", null)
  connection_bytes          = lookup(each.value, "connection_bytes", null)
  connection_limit          = lookup(each.value, "connection_limit", null)
  connection_mark           = lookup(each.value, "connection_mark", null)
  connection_rate           = lookup(each.value, "connection_rate", null)
  connection_type           = lookup(each.value, "connection_type", null)
  content                   = lookup(each.value, "content", null)
  disabled                  = lookup(each.value, "disabled", false)
  dscp                      = lookup(each.value, "dscp", null)
  dst_address               = lookup(each.value, "dst_address", null)
  dst_address_list          = lookup(each.value, "dst_address_list", null)
  dst_address_type          = lookup(each.value, "dst_address_type", null)
  dst_limit                 = lookup(each.value, "dst_limit", null)
  dst_port                  = lookup(each.value, "dst_port", null)
  fragment                  = lookup(each.value, "fragment", null)
  hotspot                   = lookup(each.value, "hotspot", null)
  icmp_options              = lookup(each.value, "icmp_options", null)
  in_bridge_port            = lookup(each.value, "in_bridge_port", null)
  in_bridge_port_list       = lookup(each.value, "in_bridge_port_list", null)
  in_interface              = lookup(each.value, "in_interface", null)
  in_interface_list         = lookup(each.value, "in_interface_list", null)
  ingress_priority          = lookup(each.value, "ingress_priority", null)
  ipsec_policy              = lookup(each.value, "ipsec_policy", null)
  ipv4_options              = lookup(each.value, "ipv4_options", null)
  jump_target               = lookup(each.value, "jump_target", null)
  layer7_protocol           = lookup(each.value, "layer7_protocol", null)
  limit                     = lookup(each.value, "limit", null)
  log                       = lookup(each.value, "log", false)
  log_prefix                = lookup(each.value, "log_prefix", null)
  nth                       = lookup(each.value, "nth", null)
  out_bridge_port           = lookup(each.value, "out_bridge_port", null)
  out_bridge_port_list      = lookup(each.value, "out_bridge_port_list", null)
  out_interface             = lookup(each.value, "out_interface", null)
  out_interface_list        = lookup(each.value, "out_interface_list", null)
  packet_mark               = lookup(each.value, "packet_mark", null)
  packet_size               = lookup(each.value, "packet_size", null)
  per_connection_classifier = lookup(each.value, "per_connection_classifier", null)
  place_before              = lookup(each.value, "place_before", null)
  port                      = lookup(each.value, "port", null)
  priority                  = lookup(each.value, "priority", null)
  protocol                  = lookup(each.value, "protocol", null)
  psd                       = lookup(each.value, "psd", null)
  random                    = lookup(each.value, "random", null)
  randomise_ports           = lookup(each.value, "randomise_ports", null)
  routing_mark              = lookup(each.value, "routing_mark", null)
  same_not_by_dst           = lookup(each.value, "same_not_by_dst", null)
  socks5_port               = lookup(each.value, "socks5_port", null)
  socks5_server             = lookup(each.value, "socks5_server", null)
  socksify_service          = lookup(each.value, "socksify_service", null)
  src_address               = lookup(each.value, "src_address", null)
  src_address_list          = lookup(each.value, "src_address_list", null)
  src_address_type          = lookup(each.value, "src_address_type", null)
  src_mac_address           = lookup(each.value, "src_mac_address", null)
  src_port                  = lookup(each.value, "src_port", null)
  tcp_mss                   = lookup(each.value, "tcp_mss", null)
  time                      = lookup(each.value, "time", null)
  to_addresses              = lookup(each.value, "to_addresses", null)
  to_ports                  = lookup(each.value, "to_ports", null)
  ttl                       = lookup(each.value, "ttl", null)

  lifecycle {
    create_before_destroy = true
  }
}
# Sort 'NAT' rules
resource "routeros_move_items" "ipv4_nat_rules" {
  count = var.configure_ipv4_firewall && var.create_ipv4_nat_rules ? 1 : 0

  resource_path = "/ip/firewall/nat"
  sequence      = [for i, _ in local.ipv4_nat_rules_indexed_map : routeros_ip_firewall_nat.ipv4_nat_rules[i].id]
  depends_on    = [routeros_ip_firewall_nat.ipv4_nat_rules]
}

# ------------------------------------------
# IPV4 'RAW' Table Rules
# ------------------------------------------
resource "routeros_ip_firewall_raw" "ipv4_raw_rules" {
  for_each   = var.configure_ipv4_firewall && var.create_ipv4_raw_rules ? local.ipv4_raw_rules_indexed_map : {}
  depends_on = [routeros_ip_firewall_addr_list.ipv4_address_list]

  # Required
  action = each.value.action
  chain  = each.value.chain

  # Optional
  address_list              = lookup(each.value, "address_list", null)
  address_list_timeout      = lookup(each.value, "address_list_timeout", null)
  comment                   = lookup(each.value, "comment", null)
  content                   = lookup(each.value, "content", null)
  disabled                  = lookup(each.value, "disabled", false)
  dscp                      = lookup(each.value, "dscp", null)
  dst_address               = lookup(each.value, "dst_address", null)
  dst_address_list          = lookup(each.value, "dst_address_list", null)
  dst_address_type          = lookup(each.value, "dst_address_type", null)
  dst_limit                 = lookup(each.value, "dst_limit", null)
  dst_port                  = lookup(each.value, "dst_port", null)
  fragment                  = lookup(each.value, "fragment", null)
  hotspot                   = lookup(each.value, "hotspot", null)
  icmp_options              = lookup(each.value, "icmp_options", null)
  in_bridge_port            = lookup(each.value, "in_bridge_port", null)
  in_bridge_port_list       = lookup(each.value, "in_bridge_port_list", null)
  in_interface              = lookup(each.value, "in_interface", null)
  in_interface_list         = lookup(each.value, "in_interface_list", null)
  ingress_priority          = lookup(each.value, "ingress_priority", null)
  ipsec_policy              = lookup(each.value, "ipsec_policy", null)
  ipv4_options              = lookup(each.value, "ipv4_options", null)
  jump_target               = lookup(each.value, "jump_target", null)
  limit                     = lookup(each.value, "limit", null)
  log                       = lookup(each.value, "log", false)
  log_prefix                = lookup(each.value, "log_prefix", null)
  nth                       = lookup(each.value, "nth", null)
  out_bridge_port           = lookup(each.value, "out_bridge_port", null)
  out_bridge_port_list      = lookup(each.value, "out_bridge_port_list", null)
  out_interface             = lookup(each.value, "out_interface", null)
  out_interface_list        = lookup(each.value, "out_interface_list", null)
  packet_mark               = lookup(each.value, "packet_mark", null)
  packet_size               = lookup(each.value, "packet_size", null)
  per_connection_classifier = lookup(each.value, "per_connection_classifier", null)
  place_before              = lookup(each.value, "place_before", null)
  port                      = lookup(each.value, "port", null)
  priority                  = lookup(each.value, "priority", null)
  protocol                  = lookup(each.value, "protocol", null)
  psd                       = lookup(each.value, "psd", null)
  random                    = lookup(each.value, "random", null)
  src_address               = lookup(each.value, "src_address", null)
  src_address_list          = lookup(each.value, "src_address_list", null)
  src_address_type          = lookup(each.value, "src_address_type", null)
  src_mac_address           = lookup(each.value, "src_mac_address", null)
  src_port                  = lookup(each.value, "src_port", null)
  tcp_flags                 = lookup(each.value, "tcp_flags", null)
  tcp_mss                   = lookup(each.value, "tcp_mss", null)
  time                      = lookup(each.value, "time", null)
  tls_host                  = lookup(each.value, "tls_host", null)
  ttl                       = lookup(each.value, "ttl", null)
  lifecycle {
    create_before_destroy = true
  }
}
# Sort 'RAW' rules
resource "routeros_move_items" "ipv4_raw_rules" {
  count = var.configure_ipv4_firewall && var.create_ipv4_raw_rules ? 1 : 0

  resource_path = "/ip/firewall/raw"
  sequence      = [for i, _ in local.ipv4_raw_rules_indexed_map : routeros_ip_firewall_raw.ipv4_raw_rules[i].id]
  depends_on    = [routeros_ip_firewall_raw.ipv4_raw_rules]
}

# ------------------------------------------
# IPV4 'MANGLE' Table Rules
# ------------------------------------------
resource "routeros_ip_firewall_mangle" "ipv4_mangle_rules" {
  for_each   = var.configure_ipv4_firewall && var.create_ipv4_mangle_rules ? local.ipv4_mangle_rules_indexed_map : {}
  depends_on = [routeros_ip_firewall_addr_list.ipv4_address_list]

  # Required
  action = each.value.action
  chain  = each.value.chain

  # Optional
  address_list              = lookup(each.value, "address_list", null)
  address_list_timeout      = lookup(each.value, "address_list_timeout", null)
  comment                   = lookup(each.value, "comment", null)
  connection_bytes          = lookup(each.value, "connection_bytes", null)
  connection_limit          = lookup(each.value, "connection_limit", null)
  connection_mark           = lookup(each.value, "connection_mark", null)
  connection_nat_state      = lookup(each.value, "connection_nat_state", null)
  connection_rate           = lookup(each.value, "connection_rate", null)
  connection_state          = lookup(each.value, "connection_state", null)
  connection_type           = lookup(each.value, "connection_type", null)
  content                   = lookup(each.value, "content", null)
  disabled                  = lookup(each.value, "disabled", false)
  dscp                      = lookup(each.value, "dscp", null)
  dst_address               = lookup(each.value, "dst_address", null)
  dst_address_list          = lookup(each.value, "dst_address_list", null)
  dst_address_type          = lookup(each.value, "dst_address_type", null)
  dst_limit                 = lookup(each.value, "dst_limit", null)
  dst_port                  = lookup(each.value, "dst_port", null)
  fragment                  = lookup(each.value, "fragment", null)
  hotspot                   = lookup(each.value, "hotspot", null)
  icmp_options              = lookup(each.value, "icmp_options", null)
  in_bridge_port            = lookup(each.value, "in_bridge_port", null)
  in_bridge_port_list       = lookup(each.value, "in_bridge_port_list", null)
  in_interface              = lookup(each.value, "in_interface", null)
  in_interface_list         = lookup(each.value, "in_interface_list", null)
  ingress_priority          = lookup(each.value, "ingress_priority", null)
  ipsec_policy              = lookup(each.value, "ipsec_policy", null)
  ipv4_options              = lookup(each.value, "ipv4_options", null)
  jump_target               = lookup(each.value, "jump_target", null)
  layer7_protocol           = lookup(each.value, "layer7_protocol", null)
  limit                     = lookup(each.value, "limit", null)
  log                       = lookup(each.value, "log", false)
  log_prefix                = lookup(each.value, "log_prefix", null)
  new_connection_mark       = lookup(each.value, "new_connection_mark", null)
  new_dscp                  = lookup(each.value, "new_dscp", null)
  new_mss                   = lookup(each.value, "new_mss", null)
  new_packet_mark           = lookup(each.value, "new_packet_mark", null)
  new_priority              = lookup(each.value, "new_priority", null)
  new_routing_mark          = lookup(each.value, "new_routing_mark", null)
  new_ttl                   = lookup(each.value, "new_ttl", null)
  nth                       = lookup(each.value, "nth", null)
  out_bridge_port           = lookup(each.value, "out_bridge_port", null)
  out_bridge_port_list      = lookup(each.value, "out_bridge_port_list", null)
  out_interface             = lookup(each.value, "out_interface", null)
  out_interface_list        = lookup(each.value, "out_interface_list", null)
  packet_mark               = lookup(each.value, "packet_mark", null)
  packet_size               = lookup(each.value, "packet_size", null)
  passthrough               = lookup(each.value, "passthrough", null)
  per_connection_classifier = lookup(each.value, "per_connection_classifier", null)
  place_before              = lookup(each.value, "place_before", null)
  port                      = lookup(each.value, "port", null)
  protocol                  = lookup(each.value, "protocol", null)
  psd                       = lookup(each.value, "psd", null)
  random                    = lookup(each.value, "random", null)
  route_dst                 = lookup(each.value, "route_dst", null)
  routing_mark              = lookup(each.value, "routing_mark", null)
  src_address               = lookup(each.value, "src_address", null)
  src_address_list          = lookup(each.value, "src_address_list", null)
  src_address_type          = lookup(each.value, "src_address_type", null)
  src_mac_address           = lookup(each.value, "src_mac_address", null)
  src_port                  = lookup(each.value, "src_port", null)
  tcp_flags                 = lookup(each.value, "tcp_flags", null)
  tcp_mss                   = lookup(each.value, "tcp_mss", null)
  time                      = lookup(each.value, "time", null)
  tls_host                  = lookup(each.value, "tls_host", null)
  ttl                       = lookup(each.value, "ttl", null)
  lifecycle {
    create_before_destroy = true
  }
}
# Sort 'MANGLE' rules
resource "routeros_move_items" "ipv4_mangle_rules" {
  count = var.configure_ipv4_firewall && var.create_ipv4_mangle_rules ? 1 : 0

  resource_path = "/ip/firewall/mangle"
  sequence      = [for i, _ in local.ipv4_mangle_rules_indexed_map : routeros_ip_firewall_mangle.ipv4_mangle_rules[i].id]
  depends_on    = [routeros_ip_firewall_mangle.ipv4_mangle_rules]
}