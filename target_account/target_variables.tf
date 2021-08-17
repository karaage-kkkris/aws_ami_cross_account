# General
variable "region" {
  description = "Region to deploy into"
  type        = string
}

variable "target_permissions_boundary" {
  description = "IAM Permissions Boundary for the target account"
  type        = string
}

variable "target_vpc_id" {
  description = "VPC for the target account"
  type        = string
}

variable "target_subnet_ids" {
  description = "Subnet IDs for the target account"
  type        = list(string)
}

variable "source_account_id" {
  description = "Account ID for the source account"
  type        = string
}

variable "source_account_name" {
  description = "Account name for the source account"
  type        = string
}

variable "target_account_id" {
  description = "Account ID for the target account"
  type        = string
}

variable "target_account_name" {
  description = "Account name for the target account"
  type        = string
}

variable "target_component_name" {
  description = "Name of the component"
  type        = string
  default     = "target-ami-creation"
}

# EC2
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
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

variable "ena_support" {
  description = "Specifies whether enhanced networking with ENA is enabled."
  type        = bool
  default     = true
}

# Snapshot
variable "snapshot_id" {
  description = "The Snapshot ID shared by the source account."
  type        = string
}
