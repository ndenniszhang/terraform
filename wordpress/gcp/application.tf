resource "google_cloud_run_v2_service" "wordpress" {
  name       = "wordpress"
  location   = var.region
  depends_on = [google_sql_database_instance.wordpress_db_instancep.name]

  template {
    containers {
      image = var.wordpress_image
      resources {
        limits = {
          cpu    = "1"
          memory = "1024Mi"
        }
      }
      env {
        name  = "WORDPRESS_DB_HOST"
        value = google_sql_database_instance.wordpress_db_instance.private_ip_address
      }
      env {
        name  = "WORDPRESS_DB_USER"
        value = var.db_user
      }
      env {
        name  = "WORDPRESS_DB_PASSWORD"
        value = var.db_password
      }
      env {
        name  = "WORDPRESS_DB_NAME"
        value = var.db_name
      }
      # env {
      #   name  = "WORDPRESS_DEBUG"
      #   value = var.debug
      # }
      ports {
        container_port = 80
      }
    }
  }

  traffic {
    percent  = 100
    revision = true
  }
}

resource "google_cloud_run_service_iam_member" "all_users" {
  service  = google_cloud_run_service.wordpress.name
  location = google_cloud_run_service.wordpress.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
