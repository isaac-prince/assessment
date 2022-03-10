variable "namespace" {
  description = "Assessment namespace is for unique resource naming"
  default     = ""
  type        = string
}

variable "ssh_keypair" {
  description = "SSH keypair to use for EC2 instance"
  default     = ""
  type        = string 
}

variable "region" {
    description = "This is the AWS region"
    default     = "af-south-1"
    type        = string
}