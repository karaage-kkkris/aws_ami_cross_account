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
variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t3a.small"
  type        = string
}
