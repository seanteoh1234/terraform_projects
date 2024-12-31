terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# # Only use this if you have the tf-bucket-965825 created already, it's to put the tf state in remote cloud storage.
# terraform {
#   backend "gcs" {
#     bucket  = "tf-bucket-965825"
#     prefix  = "terraform/state"
#   }
# }



module "instances" {

  source     = "./modules/instances"
  zone       = var.zone
  instance_type = var.instance_type
  network_name = var.network_name
  depends_on = [module.vpc]

}

module "storage" {

    source     = "./modules/storage"
    cloud_storage_bucket_name = var.cloud_storage_bucket_name

}

module "vpc" {
    source  = "terraform-google-modules/network/google"

    project_id   = var.project_id
    network_name = var.network_name

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = var.subnet1_ip
            subnet_region         = var.region
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = var.subnet2_ip
            subnet_region         = var.region
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
    ]
}

resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
 network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}