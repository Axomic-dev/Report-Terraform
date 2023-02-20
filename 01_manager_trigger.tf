resource "google_cloudbuild_trigger" "manager-us-central1" {
  name     = "report-manager-trigger"
  disabled = false

  github {
    owner = "TeamAxomic"
    name  = "Report-Manager"
    push {
      branch = "^${var.BRANCH_NAME}$"
    }
  }

  build {
    step {
      id   = "create-image"
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t",
        "gcr.io/${var.GCP_PROJECT}/${var.REPORT_MANAGER}",
        "."
      ]
    }
    step {
      id       = "upload-image"
      wait_for = ["create-image"]
      name     = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "gcr.io/${var.GCP_PROJECT}/${var.REPORT_MANAGER}"
      ]
    }
    step {
      id       = "create-service"
      wait_for = ["upload-image"]
      name     = "gcr.io/cloud-builders/gcloud"
      args = [
        "run",
        "deploy",
        "${var.REPORT_MANAGER}",
        "--region=${var.REGION1}",
        "--image=gcr.io/${var.GCP_PROJECT}/${var.REPORT_MANAGER}",
        "--allow-unauthenticated",
        "--set-env-vars",
        "NODE_ENV=${var.NODE_ENV}",
        "--set-env-vars",
        "GCP_PROJECT=${var.GCP_PROJECT}",
        "--set-env-vars",
        "GCP_SUBSCRIPTION=${var.MTOR_TOPIC}",
        "--set-env-vars",
        "CRYPTO_SECRET_KEY=${var.CRYPTO_SECRET_KEY}",
        "--set-env-vars",
        "MANAGER_COLLECTION_NAME=${var.REPORT_COLLECTION_NAME}"
      ]
    }
  }
}