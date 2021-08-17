resource "null_resource" "terminate_ec2" {
  depends_on = [
    aws_ami_from_instance.source_ami
  ]

  triggers = {
    ec2_creation = aws_instance.ec2.id
  }

  provisioner "local-exec" {
    command = templatefile("${path.module}/terminate_ec2.sh", {
      region      = var.region
      instance_id = aws_instance.ec2.id
    })
  }
}
