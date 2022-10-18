terraform {
  # Might change this to "classic" backend via S3 (wasabi)
  # https://stanislas.blog/2018/10/how-to-use-non-aws-s3-backend-terraform/

  cloud {
    organization = "LukasKnuth"

    workspaces {
      name = "lknuth_dev"
    }
  }
}

provider "github" {
  # Loads auth config from "GITHUB_TOKEN" 
}

provider "cloudflare" {
  # Loads auth config from "CLOUDFLARE_API_TOKEN"
}
