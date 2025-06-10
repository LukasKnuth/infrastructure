resource "cloudflare_record" "pages_ipv4" {
  for_each = local.github_pages_ipv4_addresses

  zone_id = local.cloudflare_zone_id
  type    = "A"
  name    = local.apex_domain
  value   = each.key
  proxied = true
}

resource "porkbun_dns_record" "pages_ipv4" {
  for_each = local.github_pages_ipv4_addresses

  domain    = local.apex_domain
  subdomain = "" # apex
  type      = "A"
  content   = each.key
}

resource "cloudflare_record" "pages_ipv6" {
  for_each = local.github_pages_ipv6_addresses

  zone_id = local.cloudflare_zone_id
  type    = "AAAA"
  name    = local.apex_domain
  value   = each.key
  proxied = true
}

resource "porkbun_dns_record" "pages_ipv6" {
  for_each = local.github_pages_ipv6_addresses

  domain    = local.apex_domain
  subdomain = "" # apex
  type      = "AAAA"
  content   = each.key
}

resource "cloudflare_record" "pages_www" {
  zone_id = local.cloudflare_zone_id
  type    = "CNAME"
  name    = "www"
  value   = local.apex_domain
  proxied = true
}

resource "porkbun_dns_record" "pages_www" {
  domain    = local.apex_domain
  subdomain = "www"
  type      = "CNAME"
  content   = local.apex_domain # just redirect back to main
}

resource "cloudflare_zone_settings_override" "overrides" {
  # When chaingng these, and getting "cant set - readonly", remove this
  # with "terraform state rm <type>.<name>" and try again.
  # https://github.com/cloudflare/terraform-provider-cloudflare/issues/1297
  zone_id = local.cloudflare_zone_id

  settings {
    # IMPORTANT! GitHub Pages cant issue LetsEncrypt cert behind CloudFlare!
    # https://community.cloudflare.com/t/github-pages-require-disabling-cfs-http-proxy/147401/31
    ssl = "flexible"

    automatic_https_rewrites = "on"
    tls_1_3                  = "on"
    always_use_https         = "on"
  }
}

resource "cloudflare_zone_dnssec" "dnssec" {
  # NOTE: This might fail on first apply with "unmarshalling error"
  # https://github.com/cloudflare/terraform-provider-cloudflare/issues/1486
  zone_id = local.cloudflare_zone_id
}
