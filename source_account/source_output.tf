output "source_ami" {
  value = aws_ami_copy.copy_encrypt_source_ami.id
}

output "source_snapshot_id" {
  value = lookup(local.block_device_mappings["/dev/sda1"].ebs, "snapshot_id", "what?")
}
