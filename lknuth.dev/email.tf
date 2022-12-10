# verify that we own the domain to mailbox.org
resource "cloudflare_record" "mailbox_validation" {
  zone_id = local.cloudflare_zone_id
  type    = "TXT"
  name    = local.mailbox_verify_dns_host
  value   = local.mailbox_verify_dns_value
}

# configure their mail-servers to be forwarded to
resource "cloudflare_record" "mailbox_mail_servers" {
  for_each = { for s in local.mailbox_servers_dns : s.server => s.priority }

  zone_id = local.cloudflare_zone_id

  type     = "MX"
  name     = local.apex_domain
  value    = each.key
  priority = each.value
}

# get better Spam ratings for custom mail domain
resource "cloudflare_record" "mailbox_spam_spf" {
  zone_id = local.cloudflare_zone_id

  type  = "TXT"
  name  = "@"
  value = local.mailbox_spf_value
}

resource "cloudflare_record" "mailbox_spam_dkim" {
  for_each = { for d in local.mailbox_dkim_dns : d.host => d.target }

  zone_id = local.cloudflare_zone_id

  type  = "CNAME"
  name  = lower(each.key)
  value = lower(each.value)
}

resource "cloudflare_record" "mailbox_spam_dmarc" {
  zone_id = local.cloudflare_zone_id

  type  = "TXT"
  name  = "_dmarc.${local.apex_domain}"
  value = "v=DMARC1;p=none;rua=mailto:${local.postmaster_email}"
}