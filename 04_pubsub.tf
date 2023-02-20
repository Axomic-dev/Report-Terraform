resource "google_pubsub_topic" "mtor" {
  name = var.MTOR_TOPIC
}

resource "google_pubsub_topic" "rtob" {
  name = var.RTOB_TOPIC
}

resource "google_pubsub_subscription" "mtor-subscriber" {
  name  = "mtor-subscriptor"
  topic = google_pubsub_topic.mtor.name

  ack_deadline_seconds       = 20
  message_retention_duration = "1200s"
  retain_acked_messages      = false
  enable_message_ordering    = false
  push_config {
    push_endpoint = "https://${var.REGION1}-${var.GCP_PROJECT}.cloudfunctions.net/${var.REPORT_REQUEST}"
    attributes = {
      x-goog-version = "v1"
    }
  }
  retry_policy {
    minimum_backoff = "10s"
  }
}

resource "google_pubsub_subscription" "rtob-subscriber" {
  name  = "rtob-subscriptor"
  topic = google_pubsub_topic.rtob.name

  ack_deadline_seconds       = 20
  message_retention_duration = "1200s"
  retain_acked_messages      = false
  enable_message_ordering    = false
  push_config {
    push_endpoint = "https://${var.REGION1}-${var.GCP_PROJECT}.cloudfunctions.net/${var.REPORT_BUILDER}"
    attributes = {
      x-goog-version = "v1"
    }
  }
  retry_policy {
    minimum_backoff = "10s"
  }
}
