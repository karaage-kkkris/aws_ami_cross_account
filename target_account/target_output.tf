output "target_ami_id" {
  value = aws_ami.custom_ami.id
}

output "cmk_arn" {
  value = aws_kms_key.target_kms_key.arn
}
