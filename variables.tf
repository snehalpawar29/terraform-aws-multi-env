# - **AMI**: `ami-0d76b909de1a0595d` (us-west-2)
# - **Instance Type**: `t3.micro`
# - **Root Volume**: 10 GB gp3
# - **Security Group**: Ports 22 (SSH) and 80 (HTTP) open inbound, all outbound allowed


variable "ami" {
  description = "AMI ID FOR ALL EC2 INSTANCES"
  type        = string
  default     = "ami-01a00762f46d584a1" #ubuntu
}
variable "instance_type" {
  description = "Instance type FOR ALL EC2 INSTANCES"
  type        = string
  default     = "t3.micro"
}
variable "volume_size" {
  description = "Root Volume Size FOR ALL EC2 INSTANCES"
  type        = number
  default     = "10"
}
variable "volume_type" {
  description = "Root Volume Type FOR ALL EC2 INSTANCES"
  type        = string
  default     = "gp3"
}

variable "key_public_path" {
  description = "Key path ALL EC2 INSTANCES"
  type        = string
  default     = "multi-env-key.pub"
}
