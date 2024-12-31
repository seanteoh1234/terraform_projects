variable "region" {
 default = "us-west1"
}

variable "zone" {
 default = "us-west1-a"
}

variable "project_id" {
 default = "qwiklabs-gcp-00-e2ddf2923a7d"
}

variable "instance_type" {
 default = "e2-standard-2"
}

variable "network_name" {
  default = "tf-vpc-112676"
}

variable "subnet1_ip" {
  default = "10.10.10.0/24"
}

variable "subnet2_ip" {
  default = "10.10.20.0/24"
}

variable "cloud_storage_bucket_name"{
  default = "sean-bucket-5"
}

