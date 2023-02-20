terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4"
    }
  }
}

provider "google" {
  project = var.GCP_PROJECT
  region  = var.REGION
  zone    = var.ZONE
}

data "google_project" "project" {}
data "google_client_config" "default" {}
