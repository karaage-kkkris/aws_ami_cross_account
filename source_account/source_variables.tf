# General
variable "region" {
  description = "Region to deploy into"
  type        = string
}

variable "source_permissions_boundary" {
  description = "IAM Permissions Boundary for the source account"
  type        = string
}

variable "source_vpc_id" {
  description = "VPC for the source account"
  type        = string
}

variable "source_subnet_ids" {
  description = "Subnet IDs for the source account"
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

variable "source_component_name" {
  description = "Name of the component"
  default     = "source-ami-creation"
  type        = string
}

# EC2
variable "ec2_id" {
  description = "ID of EC2 instance"
  type        = string
}

# KMS
variable "kms_recovery_window_in_days" {
  description = "Number of days before completely deleting a KMS."
  default     = 7
  type        = number
}

# AMI
variable "ami_copy_encrypt_option" {
  description = "Specifies whether the destination snapshots of the copied image should be encrypted."
  default     = true
  type        = bool
}

variable "ami_filter_most_recent_option" {
  description = "If more than one result is returned, use the most recent AMI."
  default     = true
  type        = bool
}
