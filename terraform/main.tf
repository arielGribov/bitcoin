
resource "google_container_cluster" "primary" {
  name               = "bitcoin-cluster"
  location           = var.zone
  initial_node_count = 2
  deletion_protection = false

  remove_default_node_pool = true
  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

data "google_client_config" "default" {}

resource "kubernetes_secret" "backend_secret" {
  metadata {
    name = "backend-secret"
  }

  data = {
    key = base64encode("your_secret_value")
  }
}
data "google_container_cluster" "gke" {
  name     = google_container_cluster.primary.name
  location = var.zone

  depends_on = [google_container_cluster.primary]
}