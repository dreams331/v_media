variable "region" {
  default = "europe-west2"
}

variable "location" {
  default = "europe-west2-a"
}

variable "network_name" {
  default = "tf-gke-k8s"
}

provider "google" {
  project     = "axial-studio-335217"
  region = var.region
}

resource "google_service_account" "v_media_service_account" {
  account_id   = "service-account@axial-studio-335217.iam.gserviceaccount.com"
  display_name = "Service Account"
}

resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name                     = var.network_name
  ip_cidr_range            = "192.165.5.85/24"
  network                  = google_compute_network.default.self_link
  region                   = var.region
  private_ip_google_access = true
}


data "google_client_config" "current" {
}

data "google_container_engine_versions" "default" {
  location = var.location
}


resource "google_container_node_pool" "np" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.primary.id
  node_config {
    machine_type = "e2-medium"
    service_account = "service-account@axial-studio-335217.iam.gserviceaccount.com"
    min_node_count = 0
    max_node_count = 3
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  timeouts {
    create = "30m"
    update = "20m"
  }
}

resource "google_container_cluster" "primary" {
  name               = var.network_name
  location           = var.location
  min_master_version = data.google_container_engine_versions.default.latest_master_version
  network            = google_compute_subnetwork.default.name
  subnetwork         = google_compute_subnetwork.default.name

  node_config {
    service_account = "service-account@axial-studio-335217.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    guest_accelerator {
      type  = "nvidia-tesla-k80"
      count = 3
    }
  }
}
