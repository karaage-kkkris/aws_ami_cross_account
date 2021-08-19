locals {
  block_device_mappings = {
    for bd in data.aws_ami.copied_ami.block_device_mappings:
      bd.device_name => bd
  }
}


resource "aws_ami_from_instance" "source_ami" {
  name               = local.name
  source_instance_id = var.ec2_id
}

resource "null_resource" "stop_ec2" {
  depends_on = [aws_ami_from_instance.source_ami]

  provisioner "local-exec" {
    command = "aws ec2 stop-instances --region ${var.region} --instance-ids ${var.ec2_id}"
  }
}

resource "aws_ami_copy" "copy_encrypt_source_ami" {
  depends_on = [
    aws_ami_from_instance.source_ami
  ]

  name              = "${local.name}-copy"
  source_ami_id     = aws_ami_from_instance.source_ami.id
  source_ami_region = var.region
  encrypted         = var.ami_copy_encrypt_option
  kms_key_id        = aws_kms_key.source_kms_key.arn
}


resource "aws_ami_launch_permission" "add_target_permission" {
  image_id   = aws_ami_copy.copy_encrypt_source_ami.id
  account_id = var.target_account_id
}

data "aws_ami" "copied_ami" {
  depends_on = [
    aws_ami_copy.copy_encrypt_source_ami
  ]

  owners      = ["self"]
  most_recent = var.ami_filter_most_recent_option
  name_regex  = "${local.name}-copy"
}

resource "aws_snapshot_create_volume_permission" "add_target_permission" {
  snapshot_id = lookup(local.block_device_mappings["/dev/sda1"].ebs, "snapshot_id", "what?")
  account_id  = var.target_account_id
}
