variable "GCP_PROJECT" {}
variable "NODE_ENV" {}
variable "API_KEY" {}
variable "API_URL" {}
variable "CRYPTO_SECRET_KEY" {
  description = "String that serves as a key to hash values"
}
variable "BRANCH_NAME" {
  default     = "main"
  description = "Name for the production branch of the GitHub repo"
}
variable "PROJECT_SRC" {
  default     = "./dist"
  description = "Path to source files of the cloud function"
}
variable "REPORT_MANAGER" {
  default     = "report-manager"
  description = "Name for Report Manager service, needed for the url"
}
variable "REPORT_REQUEST" {
  default     = "report-request"
  description = "Name for Report Request function, needed for the url"
}
variable "REPORT_BUILDER" {
  default     = "report-builder"
  description = "Name for Report Builder function, needed for the url"
}
variable "RTOB_TOPIC" {
  default     = "request2builder"
  description = "Name for Pub/Sub topic between Request and Builder"
}
variable "MTOR_TOPIC" {
  default     = "manager2request"
  description = "Name for Pub/Sub topic between Manager and Request"
}
variable "REPORT_COLLECTION_NAME" {
  default     = "report-database"
  description = "Name of collection for the firestore database"
}
variable "REGION" {
  default     = "us-central"
  description = "Region where the infrastructure is being uploaded"
}
variable "REGION1" {
  default     = "us-central1"
  description = "Region where the infrastructure is being uploaded"
}
variable "ZONE" {
  default     = "us-central-c"
  description = "Zone where the infrastructure is being uploaded"
}
