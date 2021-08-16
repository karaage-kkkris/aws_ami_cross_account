resource "aws_instance" "ec2" {
  ami           = aws_ami.custom_ami.id
  instance_type = var.ec2_instance_type

  subnet_id              = var.target_subnet_ids[0]
  key_name               = aws_secretsmanager_secret.ec2.name
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile   = aws_iam_instance_profile.target_instance_profile.name

  lifecycle {
    ignore_changes = [ami]
  }

  depends_on = [aws_security_group.ec2, aws_key_pair.ec2]
  tags       = { Name = local.name }
}

# Generate SSH key
resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create keypair in AWS using generated SSH key
resource "aws_key_pair" "ec2" {
  key_name   = local.name
  public_key = tls_private_key.generated_key.public_key_openssh
}

# Store SSH key in Secret Manager
resource "aws_secretsmanager_secret" "ec2" {
  name                    = local.name
  description             = "EC2 Keypair for ${local.name}"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "ec2" {
  secret_id     = aws_secretsmanager_secret.ec2.id
  secret_string = tls_private_key.generated_key.private_key_pem
}

resource "aws_security_group" "ec2" {
  name        = local.name
  description = "Open SSH"
  vpc_id      = var.target_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
