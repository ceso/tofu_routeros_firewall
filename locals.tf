locals {
  # ------------------------------------------
  # IPV4 Rules Indexer
  # ------------------------------------------  
  ipv4_filter_rules_indexed_map = { for idx, rule in var.ipv4_filter_rules : format("%03d", idx) => rule }
  ipv4_nat_rules_indexed_map    = { for idx, rule in var.ipv4_nat_rules : format("%03d", idx) => rule }
  ipv4_raw_rules_indexed_map    = { for idx, rule in var.ipv4_raw_rules : format("%03d", idx) => rule }
  ipv4_mangle_rules_indexed_map = { for idx, rule in var.ipv4_mangle_rules : format("%03d", idx) => rule }
}