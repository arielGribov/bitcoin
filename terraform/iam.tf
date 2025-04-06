resource "google_service_account" "gke_service_account" {
  account_id   = "my-gke-sa"
  display_name = "My GKE Service Account"
  project      = var.project_id
}

resource "google_project_iam_binding" "storage_object_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${google_service_account.gke_service_account.email}",
  ]
}