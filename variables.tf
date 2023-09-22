variable "source_cluster_identifier" {
  type        = string
  default     = ""
  description = "Aurora Cluster Identifier"
}
variable "kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID of cross account shared key"
}
locals {
  port = 3306
}
