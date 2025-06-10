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

provider "porkbun" {
  # Loads auth from "PORKBUN_API_KEY" and "PORKBUN_SECRET_API_KEY"
}
