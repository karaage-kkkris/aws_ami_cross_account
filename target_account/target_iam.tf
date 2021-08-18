# Assume role policy allowing ec2 to assume this role
data "aws_iam_policy_document" "target_ec2" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

# Create IAM role and associated instance profile for testing from the ec2
resource "aws_iam_role" "target_role" {
  name                 = local.name
  permissions_boundary = var.target_permissions_boundary
  assume_role_policy   = data.aws_iam_policy_document.target_ec2.json
}

# Define IAM policy document and policy to be attached to the testing role
data "aws_iam_policy_document" "target_policy" {
  # This provides access to all the resources which must be tested
  statement {
    resources = ["*"]
    actions = [
      "ec2:ModifySnapshotAttribute",
      "ec2:CreateImage",
      "ec2:CopyImage",
      "ec2:RegisterImage",
      "ec2:CopySnapshot",
      "ec2:Describe*",
    ]
  }

  statement {
    resources = [
      "arn:aws:kms:${var.region}:${var.source_account_id}:key/*"
    ]
    actions = [
      "kms:DescribeKey",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:Decrypt"
    ]
  }
}

resource "aws_iam_role_policy" "target_policy" {
  name   = local.name
  role   = aws_iam_role.target_role.name
  policy = data.aws_iam_policy_document.target_policy.json
}

# Create instance profile to be attached to the ec2 instance used for testing
resource "aws_iam_instance_profile" "target_instance_profile" {
  name = local.name
  role = aws_iam_role.target_role.name
}

# Attach the AmazonSSMManagedInstanceCore policy to allow EC2 access without SSH keys
resource "aws_iam_role_policy_attachment" "allow_ssm" {
  role       = aws_iam_role.target_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
