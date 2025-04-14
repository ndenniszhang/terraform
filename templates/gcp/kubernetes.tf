provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

# Create Kubernetes Namespace
resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }
}

# Create Persistent Volume Claim
resource "kubernetes_persistent_volume_claim" "app_pvc" {
  metadata {
    name      = "app-pvc"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "4Gi"
      }
    }
    storage_class_name = "standard" # Uses GCP's PD by default
  }
}

# Create Kubernetes Deployment
resource "kubernetes_deployment" "app" {
  metadata {
    name      = "app-deployment"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "app"
      }
    }

    template {
      metadata {
        labels = {
          app = "app"
        }
      }

      spec {
        container {
          image = var.container_image
          name  = "app-container"
          
          resources {
            limits = {
              cpu    = "1"
              memory = "1Gi"
            }
            requests = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }
          
          volume_mount {
            name       = "app-storage"
            mount_path = "/data"
          }
        }
        
        volume {
          name = "app-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.app_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

# Expose the application with a Service
resource "kubernetes_service" "app" {
  metadata {
    name      = "app-service"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.spec[0].template[0].metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    port {
      port        = 443
      target_port = 443
    }
    type = "ClusterIP"
  }
}