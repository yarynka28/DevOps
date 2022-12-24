provider "google" {
  credentials = file("path_to_your_json_file")
  project     = "halogen-force-372209"
  region      = "europe-west1"
}

provider "google-beta" {
 credentials = file("path_to_your_json_file")
 project     = "halogen-force-372209"
 region      = "europe-west1"
}

resource "google_compute_network" "this" {
  auto_create_subnetworks = false
  name                    = "google-compute-network"
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "this" {
  name          = "google-compute-subnetwork"
  ip_cidr_range = "192.168.24.0/24"
  region        = "europe-west1"
  network       = google_compute_network.this.id
}

resource "google_compute_global_address" "this" {
  provider = google-beta

  name          = "private-ip-db-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.this.id
}

resource "google_service_networking_connection" "this" {
  provider = google-beta

  network                 = google_compute_network.this.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.this.name]
}

resource "google_compute_firewall" "wordpress_ingress" {
  name    = "firewall-http"
  network = google_compute_network.this.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_sql_database_instance" "this" {
  database_version = "MYSQL_5_7"
  name             = "sql-for-wordpress"
  region           = "europe-west1"

  depends_on = [
  google_service_networking_connection.this]

  settings {
    availability_type = "REGIONAL"
    disk_autoresize   = false
    disk_size         = 50
    disk_type         = "PD_HDD"
    tier              = "db-g1-small"

    backup_configuration {
      enabled            = true
      start_time         = "04:00"
      binary_log_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.this.id
    }

    database_flags {
      name  = "max_connections"
      value = 500
    }
  }
}

resource "google_sql_database" "this" {
  name      = "wordpress"
  instance  = google_sql_database_instance.this.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "random_string" "this" {
  length    = 24
  special   = false
  min_upper = 5
  min_lower = 5
}

resource "random_password" "this" {
  length    = 24
  special   = false
  min_upper = 5
  min_lower = 5
}

resource "google_sql_user" "this" {
  name     = random_string.this.result
  password = random_password.this.result
  instance = google_sql_database_instance.this.name
}

output "sql_db_username" {
  value     = random_string.this.result
  sensitive = true
}
output "sql_db_password" {
  value     = random_password.this.result
  sensitive = true
}

resource "google_compute_instance" "this" {
  name         = "wordpress"
  machine_type = "e2-standard-2"
  zone         = "europe-west1-b"
  metadata_startup_script = templatefile("${path.module}/init.sh", {
    DB_USERNAME = random_string.this.result
    DB_PASSWORD = random_password.this.result
    DB_HOST     = google_sql_database_instance.this.private_ip_address
  })

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      size  = 50
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.this.id

    access_config {
      network_tier = "STANDART"
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
