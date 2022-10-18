terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.25.0"
    }
  }
}