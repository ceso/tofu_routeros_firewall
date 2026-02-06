# ------------------------------------------
# IPV4 Address Lists
# ------------------------------------------
resource "routeros_ip_firewall_addr_list" "ipv4_address_list" {
  count = var.configure_ipv4_firewall && var.create_ipv4_address_lists ? length(var.ipv4_address_list) : 0

  # Required
  address = var.ipv4_address_list[count.index].address
  list    = var.ipv4_address_list[count.index].list_name

  # Optional
  disabled = lookup(var.ipv4_address_list[count.index], "disabled", null)
  comment  = lookup(var.ipv4_address_list[count.index], "comment", null)
  timeout  = lookup(var.ipv4_address_list[count.index], "timeout", null)
}

# ------------------------------------------
# IPV6 Address Lists
# ------------------------------------------
resource "routeros_ip_firewall_addr_list" "ipv6_address_list" {
  count = var.configure_ipv6_firewall && var.create_ipv6_address_lists ? length(var.ipv6_address_list) : 0

  # Required
  address = var.ipv6_address_list[count.index].address
  list    = var.ipv6_address_list[count.index].list_name

  # Optional
  disabled = lookup(var.ipv6_address_list[count.index], "disabled", null)
  comment  = lookup(var.ipv6_address_list[count.index], "comment", null)
  timeout  = lookup(var.ipv6_address_list[count.index], "timeout", null)
}