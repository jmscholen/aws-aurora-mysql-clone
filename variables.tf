variable "source_cluster_identifier" {
  type        = string
  default     = ""
  description = "Aurora Cluster Identifier"
}

locals {
  port = 3306
}
