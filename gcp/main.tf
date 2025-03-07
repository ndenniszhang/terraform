terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# Create a Cloud Storage bucket for data persistence
resource "google_storage_bucket" "data_bucket" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}

# Create a service account for the Cloud Run service
resource "google_service_account" "service_account" {
  account_id   = "${var.service_name}-sa"
  display_name = "Service Account for ${var.service_name}"
}

# Grant the service account access to the config bucket
resource "google_storage_bucket_iam_member" "bucket_access" {
  bucket = google_storage_bucket.config_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

# Deploy a Cloud Run service
resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.docker_image

        # Mount the config volume
        volume_mounts {
          name       = "data-volume"
          mount_path = "/etc/pihole"
        }

        # Environment variables for GCS bucket access
        env {
          name  = "CONFIG_BUCKET"
          value = google_storage_bucket.config_bucket.name
        }
      }

      # Configure the service account
      service_account_name = google_service_account.service_account.email

      # Define volumes
      volumes {
        name = "data-volume"
        gcs {
          bucket = google_storage_bucket.config_bucket.name
        }
      }
    }
  }

  # Automatically determine traffic routing
  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow public access to the Cloud Run service
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.service.name
  location = google_cloud_run_service.service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

