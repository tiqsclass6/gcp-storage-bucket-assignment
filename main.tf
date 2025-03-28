terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  region      = "CHANGE-YOUR-REGION-HERE" # Change your default region; resources will specify their own region
  project     = "<PROJECT_ID_HERE>" #Insert your Project ID here
  zone        = "us-central1-b"
  credentials = "<path/to/service-account.json>" # Insert your json credential here
}

resource "google_storage_bucket" "bucket1" {
  name          = "gcp-tf-storage-bucket-tiqs"
  location      = "us-central1"
  force_destroy = true

}

resource "google_compute_network" "auto-vpc-tf" {
  name                    = "auto-vpc-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub-sg" {
  name          = "sub-sg"
  network       = google_compute_network.auto-vpc-tf.id
  ip_cidr_range = "10.231.1.0/24"
  region        = "us-central1"
}

resource "google_storage_bucket_object" "beach_image" {
  name         = "beach.jpg"
  bucket       = google_storage_bucket.bucket1.name
  source       = "storage-bucket/beach.jpg"
  content_type = "image/jpeg"
}

resource "google_storage_bucket_object" "coffee_image" {
  name         = "coffee.jpg"
  bucket       = google_storage_bucket.bucket1.name
  source       = "storage-bucket/coffee.jpg"
  content_type = "image/jpeg"
}

resource "google_storage_bucket_object" "html_page" {
  name         = "index.html"
  bucket       = google_storage_bucket.bucket1.name
  source       = "storage-bucket/index.html"
  content_type = "text/html"
}

resource "google_storage_object_access_control" "public_beach" {
  object = google_storage_bucket_object.beach_image.output_name
  bucket = google_storage_bucket.bucket1.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_object_access_control" "public_coffee" {
  object = google_storage_bucket_object.coffee_image.output_name
  bucket = google_storage_bucket.bucket1.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_object_access_control" "public_html" {
  object = google_storage_bucket_object.html_page.output_name
  bucket = google_storage_bucket.bucket1.name
  role   = "READER"
  entity = "allUsers"
}

output "auto" {
  value = google_compute_network.auto-vpc-tf.id
}

#resource "google_compute_network" "custom-vpc-tf" {
#name = "custom-vpc-tf"
#auto_create_subnetworks = false
#}

#output "custom" {
#  value = google_compute_network.custom-vpc-tf.id
#}