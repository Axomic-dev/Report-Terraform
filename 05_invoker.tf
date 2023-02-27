resource "google_cloudfunctions_function_iam_member" "request-invoker" {
  project        = var.GCP_PROJECT
  region         = var.REGION1
  cloud_function = var.REPORT_REQUEST

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "builder-invoker" {
  project        = var.GCP_PROJECT
  region         = var.REGION1
  cloud_function = var.REPORT_BUILDER

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
