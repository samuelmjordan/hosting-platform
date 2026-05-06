# Terraform Cloud backend
# 1. Create account at https://app.terraform.io
# 2. Create organization (e.g., "axolhost")
# 3. Run: terraform login
# 4. Run: terraform init

terraform {
  cloud {
    organization = "axolhost"

    workspaces {
      name = "hosting-platform"
    }
  }
}
