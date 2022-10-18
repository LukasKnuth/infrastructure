locals {
  cloudflare_zone_id = "64f0ace60d79e9265f5ef9bdf3f91d4d"
  apex_domain = "lknuth.dev"

  # Taken from https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
  github_pages_ipv4_addresses = [
    "185.199.108.153", "185.199.109.153",
    "185.199.110.153", "185.199.111.153"
  ]
  github_pages_ipv6_addresses = [
    "2606:50c0:8000::153", "2606:50c0:8001::153",
    "2606:50c0:8002::153", "2606:50c0:8003::153"
  ]
}
