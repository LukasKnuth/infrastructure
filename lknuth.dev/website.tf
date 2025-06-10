# Server GitHub Pages under apex domain
resource "porkbun_dns_record" "pages_ipv4" {
  for_each = local.github_pages_ipv4_addresses

  domain    = local.apex_domain
  subdomain = "" # apex
  type      = "A"
  content   = each.key
}

resource "porkbun_dns_record" "pages_ipv6" {
  for_each = local.github_pages_ipv6_addresses

  domain    = local.apex_domain
  subdomain = "" # apex
  type      = "AAAA"
  content   = each.key
}

# Serve the `www` subdomain as well. In practice, this redirects to the apex domain
# automatically (its a GitHub setting).
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

