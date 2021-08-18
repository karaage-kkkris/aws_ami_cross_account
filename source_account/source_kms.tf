data "aws_iam_policy_document" "source_kms_key" {
  statement {
    sid = "OwnerAccess"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*"
    ]
    resources = ["*"]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.target_account_id}:root"]
    }
    actions = [
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKeyWithoutPlaintext"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "source_kms_key" {
  description             = "KMS key used to encrypt the source snapshot."
  deletion_window_in_days = var.kms_recovery_window_in_days
  policy                  = data.aws_iam_policy_document.source_kms_key.json
}

resource "aws_kms_alias" "source_kms_key_alias" {
  name_prefix   = "alias/${local.name}"
  target_key_id = aws_kms_key.source_kms_key.arn
}
