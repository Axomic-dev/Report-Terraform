resource "google_cloudbuild_trigger" "request-us-central1" {
  name     = "report-request-trigger"
  disabled = false

  github {
    owner = var.REPO_OWNER
    name  = "Report-Request"
    push {
      branch = "^${var.BRANCH_NAME}$"
    }
  }

  build {
    step {
      id   = "install-dependencies"
      name = "node:16-alpine3.16"
      args = [
        "npm",
        "install"
      ]
    }
    step {
      id       = "compile-source"
      wait_for = ["install-dependencies"]
      name     = "node:16-alpine3.16"
      args = [
        "npm",
        "run",
        "build"
      ]
    }
    step {
      id       = "copy-package"
      wait_for = ["compile-source"]
      name     = "node:16-alpine3.16"
      args = [
        "cp",
        "package.json",
        "dist/package.json"
      ]
    }
    step {
      id       = "create-function"
      wait_for = ["copy-package"]
      name     = "gcr.io/cloud-builders/gcloud"
      args = [
        "functions",
        "deploy",
        "${var.REPORT_REQUEST}",
        "--region=${var.REGION1}",
        "--source=${var.PROJECT_SRC}",
        "--memory=512",
        "--trigger-http",
        "--runtime=nodejs16",
        "--entry-point=messageHandler",
        "--set-env-vars",
        "NODE_ENV=${var.NODE_ENV}",
        "--set-env-vars",
        "GCP_PROJECT=${var.GCP_PROJECT}",
        "--set-env-vars",
        "GCP_SUBSCRIPTION=${var.RTOB_TOPIC}",
        "--set-env-vars",
        "API_URL=${var.API_URL}",
        "--set-env-vars",
        "API_KEY=${var.API_KEY}"
      ]
    }
  }
}