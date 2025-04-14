terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.24.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Fetch GCP credentials for Kubernetes provider
data "google_client_config" "default" {}

# Create a GKE cluster
resource "google_container_cluster" "primary" {
  name     = "gke-deployment-cluster"
  location = var.zone

  # Remove default node pool after creation
  remove_default_node_pool = true
  initial_node_count       = 1

  # Networking and IP allocation
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }
}

# Create a separately managed node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]

    machine_type = "e2-micro" # shared 2 vCPU @ 2.25 GHz, 1 GB memory
    disk_size_gb = 10
    disk_type    = "pd-standard"

    labels = {
      env = "prod"
    }
  }
}
