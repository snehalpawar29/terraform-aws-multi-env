output "instance_ids" {
  description = "Instance Ids"
  value = aws_instance.this[*].id
}
output "public_ips" {
  description = "Public Ips"
  value = aws_instance.this[*].public_ip
}
output "security_group_id" {
  description = "Security Group IDs"
  value = aws_security_group.this.id
}

