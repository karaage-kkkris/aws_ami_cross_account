# General
variable "region" {
  description = "Region to deploy into"
}

variable "source_permissions_boundary" {
  description = "IAM Permissions Boundary for account"
}

variable "source_vpc_id" {
  description = "VPC for the account"
}

variable "source_subnet_ids" {
  description = "Subnet IDs for the account"
}

variable "source_account_id" {
  description = "Account ID for the source account"
}

variable "source_account_name" {
  description = "Account name for the source account"
}

variable "target_account_id" {
  description = "Account ID for the target account"
}

variable "target_account_name" {
  description = "Account name for the target account"
}

variable "source_component_name" {
  description = "Name of the component"
  default     = "source-ami-creation"
}

# EC2
variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t3a.small"
}

# KMS
variable "kms_recovery_window_in_days" {
  description = "Number of days before completely deleting a KMS."
  type        = number
  default     = 7
}

# AMI
variable "ami_copy_encrypt_option" {
  description = "Specifies whether the destination snapshots of the copied image should be encrypted."
  type        = bool
  default     = true
}

variable "ami_filter_most_recent_option" {
  description = "If more than one result is returned, use the most recent AMI."
  type        = bool
  default     = true
}
