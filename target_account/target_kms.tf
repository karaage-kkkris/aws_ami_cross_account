resource "aws_kms_key" "target_kms_key" {
  description             = "KMS key used to encrypt the snapshot in the target account."
  deletion_window_in_days = var.kms_recovery_window_in_days
}

resource "aws_kms_alias" "target_kms_key_alias" {
  name_prefix   = "alias/${local.name}"
  target_key_id = aws_kms_key.target_kms_key.arn
}
