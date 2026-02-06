# ------------------------------------------
# IPV4 Firewall Outputs
# ------------------------------------------
output "ipv4_filter_rules_id" {
  description = "ID of the 'ipv4_filter_rules_id' resources"
  value = try(routeros_ip_firewall_filter.ipv4_filter_rules[each.value].id, null)
}
output "ipv4_nat_rules" {
  description = "ID of the 'ipv4_nat_rules' resources"
  value = try(routeros_ip_firewall_nat.ipv4_nat_rules[each.value].id, null)
}
output "ipv4_raw_rules" {
  description = "ID of the 'ipv4_raw_rules' resources"
  value = try(routeros_ip_firewall_raw.ipv4_raw_rules[each.value].id, null)
}
output "ipv4_mangle_rules" {
  description = "ID of the 'ipv4_mangle_rules' resources"
  value = try(routeros_ip_firewall_mangle.ipv4_mangle_rules[each.value].id, null)
}
output "ipv4_address_list" {
  description = "ID of the 'ipv4_address_list' resources"
  value = try(routeros_ip_firewall_addr_list.ipv4_address_list[each.value].id, null)
}

# ------------------------------------------
# IPV6 Address Lists
# ------------------------------------------
# TODO