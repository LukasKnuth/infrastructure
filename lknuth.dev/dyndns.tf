# Setup for DynDNS configuration via dynv6

resource "cloudflare_record" "dyndns_nameservers" {
  for_each = local.dynv6_ns

  zone_id = local.cloudflare_zone_id

  type = "NS"
  name = "dyn.${local.apex_domain}"
  value = each.key
}