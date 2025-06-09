terraform-folder := "./lknuth.dev"

apply:
  terraform -chdir={{terraform-folder}} apply

init:
  terraform -chdir={{terraform-folder}} init

plan:
  terraform -chdir={{terraform-folder}} plan
