resource "github_repository" "repo" {
  name        = "lknuth.dev"
  description = "My personal website"
  topics      = ["website", "jekyll"]

  homepage_url = local.apex_domain

  # https://github.com/integrations/terraform-provider-github/issues/777
  pages {
    # This whole block set anything and causes when applying changes
    # Additionally, make sure "Enforce HTTPS" is checked in UI!
    cname = local.apex_domain
    source {
      branch = "main"
    }
  }

  visibility           = "public"
  vulnerability_alerts = true

  has_issues    = false
  has_projects  = false
  has_wiki      = false
  has_downloads = false
}