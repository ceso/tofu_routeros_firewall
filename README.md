# routeros_firewall

Terraform/Tofu module which creates Firewall rules on RouterOS devices.

## Features

This module aims to provide a layer of abstraction to create Firewall Adress Lists & Filter, NAT, RAW and Mangle table rules.
This is achieved by passing list(object) to the respective variable of what's being desired.
The order in which the firewall rules is written it's important, since this is exactly how they will be applied in RouterOS later.

## Usage

### Create a custom IPV4 Firewall Address list

```hcl
module "routeros_firewall" {
  source = "git@github.com:ceso/tofu_routeros_firewall.git"

  create_ipv4_address_lists = true
  ipv4_address_list = [
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
  ]
}
```

### Create a NAT rule to allow internet access via interfaces in WAN interface list

```hcl
module "routeros_firewall" {
  source = "git@github.com:ceso/tofu_routeros_firewall.git"

  configure_ipv4_firewall = true
  create_ipv4_nat_rules   = true
  ipv4_nat_rules = [
    {
      action   = "masquerade"
      chain    = "srcnat"
      comment  = "\t\t\t=========================== [ CHAIN: SRCNAT ] ==========================="
      disabled = true
    },
    {
      action             = "masquerade"
      chain              = "srcnat"
      out_interface_list = "WAN"
      ipsec_policy       = "out,none"
      comment            = "NS_M_Internet"
      disabled           = false
    },
    {
      action   = "masquerade"
      chain    = "srcnat"
      comment  = "\t\t\t=========================== [ END CHAIN: SRCNAT ] ==========================="
      disabled = true
    }
  ]
}
```

### Use the module as a Terragrunt Unit

First, check the documentation by Terragrunt regarding this:
* https://terragrunt.gruntwork.io/docs/features/units/
* https://terragrunt.gruntwork.io/docs/features/stacks/
* https://github.com/gruntwork-io/terragrunt-infrastructure-live-stacks-example
* https://github.com/gruntwork-io/terragrunt-infrastructure-catalog-example

Now, for example to use the module as a terragrunt unit it could be created a directory called 'router', and inside of it a file 'terragrunt.stack.hcl' with the following content:

```hcl
# ------------------------------------------
# Unit: RouterOS Firewall
# ------------------------------------------
unit "firewall" {
  source = "git@github.com:ceso/tofu_routeros_firewall.git"
  
  path = "firewall"

  values = merge(
    # Pass relevant defaults
    {
      configure_ipv4_firewall   = local.all_defaults.configure_ipv4_firewall
      create_ipv4_address_lists = local.all_defaults.create_ipv4_address_lists
      create_ipv4_filter_rules  = local.all_defaults.create_ipv4_filter_rules
      create_ipv4_nat_rules     = local.all_defaults.create_ipv4_nat_rules
      create_ipv4_raw_rules     = local.all_defaults.create_ipv4_raw_rules
      create_ipv4_mangle_rules  = local.all_defaults.create_ipv4_mangle_rules
      configure_ipv6_firewall   = local.all_defaults.configure_ipv6_firewall
      create_ipv6_address_lists = local.all_defaults.create_ipv6_address_lists
      create_ipv6_filter_rules  = local.all_defaults.create_ipv6_filter_rules
      create_ipv6_nat_rules     = local.all_defaults.create_ipv6_nat_rules
      create_ipv6_raw_rules     = local.all_defaults.create_ipv6_raw_rules
      create_ipv6_mangle_rules  = local.all_defaults.create_ipv6_mangle_rules
      ipv4_address_list         = local.all_defaults.ipv4_address_list
      ipv6_address_list         = local.all_defaults.ipv6_address_list
    },
    # Device-specific firewall rules from values
    {
      ipv4_filter_rules = local.ipv4_filter_rules
      ipv4_nat_rules    = local.ipv4_nat_rules
      ipv4_raw_rules    = local.ipv4_raw_rules
      ipv4_mangle_rules = local.ipv4_mangle_rules
    }
  )
}
```

## TODO

* Add support for IPV6
* Look for a way to provide an automatic creation of begin/end markers
* Better handling of routeros provider & tofu/terrraform version
* Tagging for each version of the module
* Tests

## References

To create this module I took inspiration from the following sources. Do not forget to check them out :)

* https://github.com/mirceanton/mikrotik-terraform
* https://github.com/Schwitzd/IaC-HomeRouter
* https://www.h-schmidt.net/articles/zone-based-firewalling-on-mikrotik-routers.html
* https://github.com/hsm1391/Advanced-MikroTik-Firewall/blob/main/Firewall-Rules.rsc
* https://forum.mikrotik.com/t/buying-rb1100ahx4-dude-edition-questions-about-firewall/148996/4
* https://hackmag.com/security/good-mikrotik
* https://hackmag.com/devops/mikrotik-firewall
* https://hackmag.com/devops/mikrotik-firewall-lvl2
* https://help.mikrotik.com/docs/spaces/ROS/pages/328513/Building+Advanced+Firewall
* https://help.mikrotik.com/docs/spaces/ROS/pages/250708066/Firewall
* https://help.mikrotik.com/docs/spaces/ROS/pages/328227/Packet+Flow+in+RouterOS
* https://help.mikrotik.com/docs/spaces/ROS/pages/154042369/Port+knocking
* https://help.mikrotik.com/docs/spaces/ROS/pages/28606504/DDoS+Protection
* https://help.mikrotik.com/docs/spaces/ROS/pages/131366985/Connection+rate
* https://help.mikrotik.com/docs/spaces/ROS/pages/268337176/Bruteforce+prevention

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_routeros"></a> [routeros](#requirement\_routeros) | 1.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_routeros"></a> [routeros](#provider\_routeros) | 1.99.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [routeros_ip_firewall_addr_list.ipv4_address_list](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_firewall_addr_list) | resource |
| [routeros_ip_firewall_addr_list.ipv6_address_list](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_firewall_addr_list) | resource |
| [routeros_ip_firewall_filter.ipv4_filter_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_firewall_filter) | resource |
| [routeros_ip_firewall_mangle.ipv4_mangle_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_firewall_mangle) | resource |
| [routeros_ip_firewall_nat.ipv4_nat_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_firewall_nat) | resource |
| [routeros_ip_firewall_raw.ipv4_raw_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/ip_firewall_raw) | resource |
| [routeros_move_items.ipv4_filter_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/move_items) | resource |
| [routeros_move_items.ipv4_mangle_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/move_items) | resource |
| [routeros_move_items.ipv4_nat_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/move_items) | resource |
| [routeros_move_items.ipv4_raw_rules](https://registry.terraform.io/providers/terraform-routeros/routeros/1.99.0/docs/resources/move_items) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configure_ipv4_firewall"></a> [configure\_ipv4\_firewall](#input\_configure\_ipv4\_firewall) | Whether to configure the IPV4 Firewall or not | `bool` | `false` | no |
| <a name="input_configure_ipv6_firewall"></a> [configure\_ipv6\_firewall](#input\_configure\_ipv6\_firewall) | Whether to configure the IPV6 Firewall or not | `bool` | `false` | no |
| <a name="input_create_ipv4_address_lists"></a> [create\_ipv4\_address\_lists](#input\_create\_ipv4\_address\_lists) | Whether to create IPV4 Firewall Address lists or not | `bool` | `false` | no |
| <a name="input_create_ipv4_filter_rules"></a> [create\_ipv4\_filter\_rules](#input\_create\_ipv4\_filter\_rules) | Whether to create IPV4 'flter' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv4_mangle_rules"></a> [create\_ipv4\_mangle\_rules](#input\_create\_ipv4\_mangle\_rules) | Whether to create IPV4 'mangle' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv4_nat_rules"></a> [create\_ipv4\_nat\_rules](#input\_create\_ipv4\_nat\_rules) | Whether to create IPV4 'nat' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv4_raw_rules"></a> [create\_ipv4\_raw\_rules](#input\_create\_ipv4\_raw\_rules) | Whether to create IPV4 'raw' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv6_address_lists"></a> [create\_ipv6\_address\_lists](#input\_create\_ipv6\_address\_lists) | Whether to create IPV6 Firewall Address lists or not | `bool` | `false` | no |
| <a name="input_create_ipv6_filter_rules"></a> [create\_ipv6\_filter\_rules](#input\_create\_ipv6\_filter\_rules) | Whether to create IPV6 'flter' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv6_mangle_rules"></a> [create\_ipv6\_mangle\_rules](#input\_create\_ipv6\_mangle\_rules) | Whether to create IPV6 'mangle' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv6_nat_rules"></a> [create\_ipv6\_nat\_rules](#input\_create\_ipv6\_nat\_rules) | Whether to create IPV6 'nat' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_create_ipv6_raw_rules"></a> [create\_ipv6\_raw\_rules](#input\_create\_ipv6\_raw\_rules) | Whether to create IPV6 'raw' table Firewall rules or not | `bool` | `false` | no |
| <a name="input_ipv4_address_list"></a> [ipv4\_address\_list](#input\_ipv4\_address\_list) | List of IPV4 Firewall Address Lists | <pre>list(object({<br/>    # Required<br/>    address   = string<br/>    list_name = string<br/><br/>    # Optional<br/>    disabled = optional(bool, false)<br/>    comment  = optional(string)<br/>    timeout  = optional(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "address": "224.0.0.0/4",<br/>    "comment": "multicast|DAL4",<br/>    "list_name": "AL_BL_NoForwardIPV4"<br/>  },<br/>  {<br/>    "address": "255.255.255.255",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NoForwardIPV4"<br/>  },<br/>  {<br/>    "address": "127.0.0.0/8",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_BadIPV4"<br/>  },<br/>  {<br/>    "address": "192.0.0.0/24",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_BadIPV4"<br/>  },<br/>  {<br/>    "address": "192.0.2.0/24",<br/>    "comment": "RFC6890 documentation|DAL4",<br/>    "list_name": "AL_BL_BadIPV4"<br/>  },<br/>  {<br/>    "address": "198.51.100.0/24",<br/>    "comment": "RFC6890 documentation|DAL4",<br/>    "list_name": "AL_BL_BadIPV4"<br/>  },<br/>  {<br/>    "address": "203.0.113.0/24",<br/>    "comment": "RFC6890 documentation|DAL4",<br/>    "list_name": "AL_BL_BadIPV4"<br/>  },<br/>  {<br/>    "address": "240.0.0.0/4",<br/>    "comment": "RFC6890 reserved|DAL4",<br/>    "list_name": "AL_BL_BadIPV4"<br/>  },<br/>  {<br/>    "address": "0.0.0.0/8",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "10.0.0.0/8",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "100.64.0.0/10",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "169.254.0.0/16",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "172.16.0.0/12",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "192.0.0.0/29",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "192.168.0.0/16",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "198.18.0.0/15",<br/>    "comment": "RFC6890 benchmark|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "255.255.255.255",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_NotGlobalIPV4"<br/>  },<br/>  {<br/>    "address": "224.0.0.0/4",<br/>    "comment": "multicast",<br/>    "list_name": "AL_BL_BadSrcIPV4"<br/>  },<br/>  {<br/>    "address": "255.255.255.255",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_BadSrcIPV4"<br/>  },<br/>  {<br/>    "address": "0.0.0.0/8",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_BadDstIPV4"<br/>  },<br/>  {<br/>    "address": "224.0.0.0/4",<br/>    "comment": "RFC6890|DAL4",<br/>    "list_name": "AL_BL_BadDstIPV4"<br/>  }<br/>]</pre> | no |
| <a name="input_ipv4_filter_rules"></a> [ipv4\_filter\_rules](#input\_ipv4\_filter\_rules) | List of IPv4 firewall filter rules | <pre>list(object({<br/>    # Required<br/>    action = string<br/>    chain  = string<br/><br/>    # Optional<br/>    disabled                  = optional(bool, false)<br/>    log                       = optional(bool, false)<br/>    fragment                  = optional(bool)<br/>    hw_offload                = optional(bool)<br/>    random                    = optional(number)<br/>    dscp                      = optional(number)<br/>    ingress_priority          = optional(number)<br/>    priority                  = optional(number)<br/>    address_list              = optional(string)<br/>    address_list_timeout      = optional(string)<br/>    comment                   = optional(string)<br/>    connection_bytes          = optional(string)<br/>    connection_limit          = optional(string)<br/>    connection_mark           = optional(string)<br/>    connection_nat_state      = optional(string)<br/>    connection_rate           = optional(string)<br/>    connection_state          = optional(string)<br/>    connection_type           = optional(string)<br/>    content                   = optional(string)<br/>    dst_address               = optional(string)<br/>    dst_address_list          = optional(string)<br/>    dst_address_type          = optional(string)<br/>    dst_limit                 = optional(string)<br/>    dst_port                  = optional(string)<br/>    hotspot                   = optional(string)<br/>    icmp_options              = optional(string)<br/>    in_bridge_port            = optional(string)<br/>    in_bridge_port_list       = optional(string)<br/>    in_interface              = optional(string)<br/>    in_interface_list         = optional(string)<br/>    ipsec_policy              = optional(string)<br/>    ipv4_options              = optional(string)<br/>    jump_target               = optional(string)<br/>    layer7_protocol           = optional(string)<br/>    limit                     = optional(string)<br/>    log_prefix                = optional(string)<br/>    nth                       = optional(string)<br/>    out_bridge_port           = optional(string)<br/>    out_bridge_port_list      = optional(string)<br/>    out_interface             = optional(string)<br/>    out_interface_list        = optional(string)<br/>    packet_mark               = optional(string)<br/>    packet_size               = optional(string)<br/>    per_connection_classifier = optional(string)<br/>    place_before              = optional(string)<br/>    port                      = optional(string)<br/>    protocol                  = optional(string)<br/>    psd                       = optional(string)<br/>    reject_with               = optional(string)<br/>    routing_mark              = optional(string)<br/>    routing_table             = optional(string)<br/>    src_address               = optional(string)<br/>    src_address_list          = optional(string)<br/>    src_address_type          = optional(string)<br/>    src_mac_address           = optional(string)<br/>    src_port                  = optional(string)<br/>    tcp_flags                 = optional(string)<br/>    tcp_mss                   = optional(string)<br/>    time                      = optional(string)<br/>    tls_host                  = optional(string)<br/>    ttl                       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ipv4_mangle_rules"></a> [ipv4\_mangle\_rules](#input\_ipv4\_mangle\_rules) | List of IPv4 firewall mangle rules | <pre>list(object({<br/>    # Required<br/>    action = string<br/>    chain  = string<br/><br/>    # Optional<br/>    disabled                  = optional(bool, false)<br/>    log                       = optional(bool, false)<br/>    passthrough               = optional(bool)<br/>    fragment                  = optional(bool)<br/>    ingress_priority          = optional(number)<br/>    new_dscp                  = optional(number)<br/>    random                    = optional(number)<br/>    dscp                      = optional(number)<br/>    address_list              = optional(string)<br/>    address_list_timeout      = optional(string)<br/>    comment                   = optional(string)<br/>    connection_bytes          = optional(string)<br/>    connection_limit          = optional(string)<br/>    connection_mark           = optional(string)<br/>    connection_nat_state      = optional(string)<br/>    connection_rate           = optional(string)<br/>    connection_state          = optional(string)<br/>    connection_type           = optional(string)<br/>    content                   = optional(string)<br/>    dst_address               = optional(string)<br/>    dst_address_list          = optional(string)<br/>    dst_address_type          = optional(string)<br/>    dst_limit                 = optional(string)<br/>    dst_port                  = optional(string)<br/>    hotspot                   = optional(string)<br/>    icmp_options              = optional(string)<br/>    in_bridge_port            = optional(string)<br/>    in_bridge_port_list       = optional(string)<br/>    in_interface              = optional(string)<br/>    in_interface_list         = optional(string)<br/>    ipsec_policy              = optional(string)<br/>    ipv4_options              = optional(string)<br/>    jump_target               = optional(string)<br/>    layer7_protocol           = optional(string)<br/>    limit                     = optional(string)<br/>    log_prefix                = optional(string)<br/>    new_connection_mark       = optional(string)<br/>    new_mss                   = optional(string)<br/>    new_packet_mark           = optional(string)<br/>    new_priority              = optional(string)<br/>    new_routing_mark          = optional(string)<br/>    new_ttl                   = optional(string)<br/>    nth                       = optional(string)<br/>    out_bridge_port           = optional(string)<br/>    out_bridge_port_list      = optional(string)<br/>    out_interface             = optional(string)<br/>    out_interface_list        = optional(string)<br/>    packet_mark               = optional(string)<br/>    packet_size               = optional(string)<br/>    per_connection_classifier = optional(string)<br/>    place_before              = optional(string)<br/>    port                      = optional(string)<br/>    protocol                  = optional(string)<br/>    psd                       = optional(string)<br/>    route_dst                 = optional(string)<br/>    routing_mark              = optional(string)<br/>    src_address               = optional(string)<br/>    src_address_list          = optional(string)<br/>    src_address_type          = optional(string)<br/>    src_mac_address           = optional(string)<br/>    src_port                  = optional(string)<br/>    tcp_flags                 = optional(string)<br/>    tcp_mss                   = optional(string)<br/>    time                      = optional(string)<br/>    tls_host                  = optional(string)<br/>    ttl                       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ipv4_nat_rules"></a> [ipv4\_nat\_rules](#input\_ipv4\_nat\_rules) | List of IPv4 NAT rules to create | <pre>list(object({<br/>    # Required<br/>    action = string<br/>    chain  = string<br/><br/>    # Optional<br/>    disabled                  = optional(bool, false)<br/>    log                       = optional(bool, false)<br/>    fragment                  = optional(bool)<br/>    randomise_ports           = optional(bool)<br/>    same_not_by_dst           = optional(bool)<br/>    socks5_port               = optional(number)<br/>    ingress_priority          = optional(number)<br/>    dscp                      = optional(number)<br/>    priority                  = optional(number)<br/>    random                    = optional(number)<br/>    address_list              = optional(string)<br/>    address_list_timeout      = optional(string)<br/>    comment                   = optional(string)<br/>    connection_bytes          = optional(string)<br/>    connection_limit          = optional(string)<br/>    connection_mark           = optional(string)<br/>    connection_rate           = optional(string)<br/>    connection_type           = optional(string)<br/>    content                   = optional(string)<br/>    dst_address               = optional(string)<br/>    dst_address_list          = optional(string)<br/>    dst_address_type          = optional(string)<br/>    dst_limit                 = optional(string)<br/>    dst_port                  = optional(string)<br/>    hotspot                   = optional(string)<br/>    icmp_options              = optional(string)<br/>    in_bridge_port            = optional(string)<br/>    in_bridge_port_list       = optional(string)<br/>    in_interface              = optional(string)<br/>    in_interface_list         = optional(string)<br/>    ipsec_policy              = optional(string)<br/>    ipv4_options              = optional(string)<br/>    jump_target               = optional(string)<br/>    layer7_protocol           = optional(string)<br/>    limit                     = optional(string)<br/>    log_prefix                = optional(string)<br/>    nth                       = optional(string)<br/>    out_bridge_port           = optional(string)<br/>    out_bridge_port_list      = optional(string)<br/>    out_interface             = optional(string)<br/>    out_interface_list        = optional(string)<br/>    packet_mark               = optional(string)<br/>    packet_size               = optional(string)<br/>    per_connection_classifier = optional(string)<br/>    place_before              = optional(string)<br/>    port                      = optional(string)<br/>    protocol                  = optional(string)<br/>    psd                       = optional(string)<br/>    routing_mark              = optional(string)<br/>    socks5_server             = optional(string)<br/>    socksify_service          = optional(string)<br/>    src_address               = optional(string)<br/>    src_address_list          = optional(string)<br/>    src_address_type          = optional(string)<br/>    src_mac_address           = optional(string)<br/>    src_port                  = optional(string)<br/>    tcp_mss                   = optional(string)<br/>    time                      = optional(string)<br/>    to_addresses              = optional(string)<br/>    to_ports                  = optional(string)<br/>    ttl                       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ipv4_raw_rules"></a> [ipv4\_raw\_rules](#input\_ipv4\_raw\_rules) | List of IPv4 firewall raw rules | <pre>list(object({<br/>    # Required<br/>    action = string<br/>    chain  = string<br/><br/>    # Optional<br/>    disabled                  = optional(bool, false)<br/>    log                       = optional(bool, false)<br/>    fragment                  = optional(bool)<br/>    dscp                      = optional(number)<br/>    ingress_priority          = optional(number)<br/>    priority                  = optional(number)<br/>    random                    = optional(number)<br/>    address_list              = optional(string)<br/>    address_list_timeout      = optional(string)<br/>    comment                   = optional(string)<br/>    content                   = optional(string)<br/>    dst_address               = optional(string)<br/>    dst_address_list          = optional(string)<br/>    dst_address_type          = optional(string)<br/>    dst_limit                 = optional(string)<br/>    dst_port                  = optional(string)<br/>    hotspot                   = optional(string)<br/>    icmp_options              = optional(string)<br/>    in_bridge_port            = optional(string)<br/>    in_bridge_port_list       = optional(string)<br/>    in_interface              = optional(string)<br/>    in_interface_list         = optional(string)<br/>    ipsec_policy              = optional(string)<br/>    ipv4_options              = optional(string)<br/>    jump_target               = optional(string)<br/>    limit                     = optional(string)<br/>    log_prefix                = optional(string)<br/>    nth                       = optional(string)<br/>    out_bridge_port           = optional(string)<br/>    out_bridge_port_list      = optional(string)<br/>    out_interface             = optional(string)<br/>    out_interface_list        = optional(string)<br/>    packet_mark               = optional(string)<br/>    packet_size               = optional(string)<br/>    per_connection_classifier = optional(string)<br/>    place_before              = optional(string)<br/>    port                      = optional(string)<br/>    protocol                  = optional(string)<br/>    psd                       = optional(string)<br/>    src_address               = optional(string)<br/>    src_address_list          = optional(string)<br/>    src_address_type          = optional(string)<br/>    src_mac_address           = optional(string)<br/>    src_port                  = optional(string)<br/>    tcp_flags                 = optional(string)<br/>    tcp_mss                   = optional(string)<br/>    time                      = optional(string)<br/>    tls_host                  = optional(string)<br/>    ttl                       = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ipv6_address_list"></a> [ipv6\_address\_list](#input\_ipv6\_address\_list) | List of IPV6 Firewall Address Lists | <pre>list(object({<br/>    # Required<br/>    address   = string<br/>    list_name = string<br/><br/>    # Optional<br/>    disabled = optional(bool, false)<br/>    comment  = optional(string)<br/>    timeout  = optional(string)<br/>  }))</pre> | <pre>[<br/>  {<br/>    "address": "::1/128",<br/>    "comment": "RFC6890 lo|DAL6",<br/>    "list_name": "AL_BL_BadIPV6"<br/>  },<br/>  {<br/>    "address": "::ffff:0:0/96",<br/>    "comment": "RFC6890 IPv4 mapped|DAL6",<br/>    "list_name": "AL_BL_BadIPV6"<br/>  },<br/>  {<br/>    "address": "2001::/23",<br/>    "comment": "RFC6890|DAL6",<br/>    "list_name": "AL_BL_BadIPV6"<br/>  },<br/>  {<br/>    "address": "2001:db8::/32",<br/>    "comment": "RFC6890 documentation|DAL6",<br/>    "list_name": "AL_BL_BadIPV6"<br/>  },<br/>  {<br/>    "address": "2001:10::/28",<br/>    "comment": "RFC6890 orchid|DAL6",<br/>    "list_name": "AL_BL_BadIPV6"<br/>  },<br/>  {<br/>    "address": "::/96",<br/>    "comment": "ipv4 compat|DAL6",<br/>    "list_name": "AL_BL_BadIPV6"<br/>  },<br/>  {<br/>    "address": "100::/64",<br/>    "comment": "RFC6890 Discard-only|DAL6",<br/>    "list_name": "AL_BL_NotGlobalIPV6"<br/>  },<br/>  {<br/>    "address": "2001::/32",<br/>    "comment": "RFC6890 TEREDO|DAL6",<br/>    "list_name": "AL_BL_NotGlobalIPV6"<br/>  },<br/>  {<br/>    "address": "2001:2::/48",<br/>    "comment": "RFC6890 Benchmark|DAL6",<br/>    "list_name": "AL_BL_NotGlobalIPV6"<br/>  },<br/>  {<br/>    "address": "fc00::/7",<br/>    "comment": "RFC6890 Unique-Local|DAL6",<br/>    "list_name": "AL_BL_NotGlobalIPV6"<br/>  },<br/>  {<br/>    "address": "::/128",<br/>    "comment": "unspecified|DAL6",<br/>    "list_name": "AL_BL_BadDstIPV6"<br/>  },<br/>  {<br/>    "address": "::/128",<br/>    "comment": "unspecified|DAL6",<br/>    "list_name": "AL_BL_BadSrcIPV6"<br/>  },<br/>  {<br/>    "address": "ff00::/8",<br/>    "comment": "multicast|DAL6",<br/>    "list_name": "AL_BL_BadSrcIPV6"<br/>  }<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ipv4_address_list"></a> [ipv4\_address\_list](#output\_ipv4\_address\_list) | ID of the 'ipv4\_address\_list' resources |
| <a name="output_ipv4_filter_rules_id"></a> [ipv4\_filter\_rules\_id](#output\_ipv4\_filter\_rules\_id) | ID of the 'ipv4\_filter\_rules\_id' resources |
| <a name="output_ipv4_mangle_rules"></a> [ipv4\_mangle\_rules](#output\_ipv4\_mangle\_rules) | ID of the 'ipv4\_mangle\_rules' resources |
| <a name="output_ipv4_nat_rules"></a> [ipv4\_nat\_rules](#output\_ipv4\_nat\_rules) | ID of the 'ipv4\_nat\_rules' resources |
| <a name="output_ipv4_raw_rules"></a> [ipv4\_raw\_rules](#output\_ipv4\_raw\_rules) | ID of the 'ipv4\_raw\_rules' resources |
<!-- END_TF_DOCS -->
