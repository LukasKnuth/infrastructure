# Setup for DynDNS configuration via dynv6
resource "porkbun_dns_record" "dyndns_nameservers" {
  for_each = local.dynv6_ns

  domain    = local.apex_domain
  subdomain = "dyn"
  type      = "NS"
  content   = each.key
}
