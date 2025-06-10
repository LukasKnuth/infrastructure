terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.25.0"
    }
    porkbun = {
      source  = "marcfrederick/porkbun"
      version = "1.2.0"
    }
  }
}
