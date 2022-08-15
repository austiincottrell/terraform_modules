resource "google_service_account" "service_account" {
  count        = length(var.gke_sa)
  project      = var.project_id
  account_id   = lookup(var.gke_sa[count.index], "sa_name")
  display_name = var.description
}

locals {
  all_service_account_roles = concat(var.gke_sa_roles, [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ])
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = toset(local.all_service_account_roles)

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}