# verify that we own the domain to mailbox.org
resource "porkbun_dns_record" "mailbox_validation" {
  domain    = local.apex_domain
  type      = "TXT"
  subdomain = local.mailbox_verify.name
  content   = local.mailbox_verify.value
}

# configure their mail-servers to be forwarded to
resource "porkbun_dns_record" "mailbox_mail_servers" {
  for_each = { for s in local.mailbox_servers_dns : s.server => s.priority }

  domain    = local.apex_domain
  subdomain = ""
  type      = "MX"
  content   = each.key
  prio      = each.value
}

# get better Spam ratings for custom mail domain
resource "porkbun_dns_record" "mailbox_spam_spf" {
  domain    = local.apex_domain
  type      = "TXT"
  subdomain = ""
  content   = local.mailbox_spf_value
}

resource "porkbun_dns_record" "mailbox_spam_dkim" {
  for_each = { for d in local.mailbox_dkim : d.name => d.value }

  domain    = local.apex_domain
  type      = "CNAME"
  subdomain = lower(each.key)
  content   = lower(each.value)
}

resource "porkbun_dns_record" "mailbox_spam_dmarc" {
  domain    = local.apex_domain
  type      = "TXT"
  subdomain = "_dmarc"
  content   = "v=DMARC1;p=none;rua=mailto:${local.postmaster_email}"
}
