#       define variables and it's structure
variable "instance_type" {
  type = string
}
variable "cidr_blocks" {
  description = "cidr block for vpc and subnet in a list"
  type = list(object({
    cidr_block = string
    name       = string
  }))
}
variable "env_prefix" {
  description = "environment prefix"
  type        = string
}
variable "region" {
  description = "aws-region"
  type        = string
}
variable "a_z" {
  description = "availability_zone"
  type        = string
}
variable "public_key_location" {
  description = "location of key pair file on machine"
  type        = string
}