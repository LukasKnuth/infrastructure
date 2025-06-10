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
  # Must point to the github name directly, otherwise GitHub Pages does not create a
  # TLS certificate that is valid for both Apex and WWW subdomain.
  # See https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https#verifying-the-dns-configuration
  content = "lukasknuth.github.io"
}

# Setup GitHub Pages verification as a security measure to disallow any other accounts from
# using my domain in their sites.
# See https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages
resource "porkbun_dns_record" "pages_verify" {
  domain    = local.apex_domain
  type      = "TXT"
  subdomain = lower(local.github_pages_verify.name)
  content   = lower(local.github_pages_verify.value)
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
