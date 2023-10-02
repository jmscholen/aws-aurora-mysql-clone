resource "aws_kms_key" "this" {
  description         = "Encryption key for Aurora MySQL Postgres ${local.resource_name}"
  enable_key_rotation = true
  is_enabled          = true
  tags                = local.tags
  policy              = data.aws_iam_policy_document.encryption_key.json
}

data "aws_iam_policy_document" "encryption_key" {
  statement {
    sid       = "Enable IAM User permissions"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid       = "AllowUseOfRootAccountKey"
    effect    = "Allow"
    resources = ["${var.arn_of_external_account_key}"]
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid       = "AllowAttachmentOfPersistentResources"
    effect    = "Allow"
    resources = ["${var.arn_of_external_account_key}"]
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    condition {
      test     = "Bool"
      values   = ["true"]
      variable = "kms:GrantIsForAWSResource"
    }
  }
}
