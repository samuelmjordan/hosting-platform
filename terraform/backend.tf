# Remote state backend configuration
# Update these values with your S3-compatible backend details
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "hosting-platform/terraform.tfstate"
    region = "us-east-1"

    # Uncomment and configure for S3-compatible backends (e.g., MinIO, Wasabi)
    # endpoint                    = "https://s3.example.com"
    # skip_credentials_validation = true
    # skip_metadata_api_check     = true
    # skip_region_validation      = true
    # force_path_style            = true
  }
}
