resource "google_service_account" "service_account" {
  for_each     = { for y in var.gke_sa : y.name => y }
  project      = var.project_id
  account_id   = each.value.sa_name
  display_name = var.description
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = { for y in var.gke_sa : y.name => y }

  project  = var.project_id
  role     = each.value.role
  member   = "serviceAccount:${google_service_account.service_account[each.value.sa_name].email}"
}