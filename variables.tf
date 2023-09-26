variable "source_cluster_identifier" {
  type        = string
  default     = ""
  description = "Aurora Cluster Identifier"
}

variable "arn_of_external_account_key" {
  type        = string
  default     = ""
  description = "The ARN of the external account key. The key must have a key policy set for allowing this account use of the key."
}

locals {
  port = 3306
}
