resource "aws_ebs_snapshot_copy" "copy_snapshot_to_own" {
  encrypted          = var.ami_copy_encrypt_option
  kms_key_id         = aws_kms_key.target_kms_key.arn
  source_region      = var.region
  source_snapshot_id = var.snapshot_id
}

resource "aws_ami" "custom_ami" {
  name                = local.name
  ena_support         = var.ena_support
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"

  ebs_block_device {
    device_name = "/dev/sda1"
    snapshot_id = aws_ebs_snapshot_copy.copy_snapshot_to_own.id
  }
}
