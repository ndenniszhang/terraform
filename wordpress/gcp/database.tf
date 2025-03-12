resource "google_sql_database_instance" "wordpress_db_instance" {
  name             = "wordpress-db-instance"
  database_version = "MYSQL_8_4"

  settings {
    tier              = "db-f1-micro"
    # activation_policy = "ON_DEMAND"
  }

  deletion_protection = false
}

resource "google_sql_database" "wordpress_db" {
  name     = var.db_name
  instance = google_sql_database_instance.wordpress_db_instance.name
}

resource "google_sql_user" "wordpress_user" {
  name     = var.db_user
  instance = google_sql_database_instance.wordpress_db_instance.name
  password = var.db_password
}
