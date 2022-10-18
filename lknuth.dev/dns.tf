resource "cloudflare_record" "pages_ipv4" {
  zone_id = local.cloudflare_zone_id
  type    = "A"
  name    = local.apex_domain
  value   = "185.199.108.153" # todo add other IPs!
  proxied = true
}

resource "cloudflare_record" "pages_www_ipv4" {
  zone_id = local.cloudflare_zone_id
  type    = "CNAME"
  name    = "www"
  value   = local.apex_domain
  proxied = true
}

# todo add AAAA records!

resource "cloudflare_zone_settings_override" "overrides" {
  # When chaingng these, and getting "cant set - readonly", remove this
  # with "terraform state rm <type>.<name>" and try again.
  # https://github.com/cloudflare/terraform-provider-cloudflare/issues/1297
  zone_id = local.cloudflare_zone_id

  settings {
	automatic_https_rewrites = "on"
	tls_1_3 = "on"
	ssl = "strict"
	always_use_https = "on"
  }
}