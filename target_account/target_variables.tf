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

variable "ami_id" {
  description = "ID of the custom AMI"
  type        = string
}
