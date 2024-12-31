resource "google_storage_bucket" "sean-bucket" {
  name          = var.cloud_storage_bucket_name
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}