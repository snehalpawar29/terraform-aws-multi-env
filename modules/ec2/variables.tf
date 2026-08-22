variable "env" {
  description = "Env Name"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "instance_count" {
  description = "Instance Count"
  type        = number
}

variable "key_public_path" {
  description = "Public Key Path"
  type        = string
}

variable "volume_size" {
  description = "Root Volume Size FOR ALL EC2 INSTANCES"
  type        = number
}
variable "volume_type" {
  description = "Root Volume Type FOR ALL EC2 INSTANCES"
  type        = string
}
variable "common_tags" {
  description = "Instance Count"
  type        = map(string)
  default     = {}
}

