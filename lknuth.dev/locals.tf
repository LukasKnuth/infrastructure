locals {
  apex_domain      = "lknuth.dev"
  postmaster_email = "lukas.knuth@mailbox.org"

  # Taken from https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
  github_pages_ipv4_addresses = toset([
    "185.199.108.153", "185.199.109.153",
    "185.199.110.153", "185.199.111.153"
  ])
  github_pages_ipv6_addresses = toset([
    "2606:50c0:8000::153", "2606:50c0:8001::153",
    "2606:50c0:8002::153", "2606:50c0:8003::153"
  ])
  github_pages_verify = {
    name = "_github-pages-challenge-LukasKnuth", value = "3a0a314b5d64ea815f72f149cb9ac5"
  }

  # Taken from the mailbox configuration dialoge
  mailbox_verify = {
    name = "c7c2ce1b7cdb29a3d22099d6db062d0f8c6aec25", value = "9e2ad31517ea49bfb7915db8b5d31621918ceed5"
  }
  mailbox_servers_dns = [
    { server = "mxext1.mailbox.org.", priority = 10 },
    { server = "mxext2.mailbox.org.", priority = 10 },
    { server = "mxext3.mailbox.org.", priority = 20 }
  ]

  # Taken from https://kb.mailbox.org/de/privat/e-mail-mit-eigener-domain/spam-reputation-der-eigenen-domain-verbessern-mit-spf-dkim-und-dmarc
  mailbox_spf_value = "v=spf1 include:mailbox.org ~all"
  mailbox_dkim = [
    { name = "MBO0001._domainkey", value = "MBO0001._domainkey.mailbox.org." },
    { name = "MBO0002._domainkey", value = "MBO0002._domainkey.mailbox.org." },
    { name = "MBO0003._domainkey", value = "MBO0003._domainkey.mailbox.org." },
    { name = "MBO0004._domainkey", value = "MBO0004._domainkey.mailbox.org." }
  ]

  # dynv6 Nameservers taken from controle plane
  dynv6_ns = toset([
    "ns1.dynv6.com.", "ns2.dynv6.com.", "ns3.dynv6.com."
  ])
}
