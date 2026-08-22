output "current_workspace" {
  description = "CURRENT WORKSPACE"
  value       = terraform.workspace
}
output "ec2_instance_ids" {
  description = "EC2 INSTANCE IDS"
  value       = module.ec2.instance_ids
}
output "ec2_public_ips" {
  description = "EC2 PUBLIC IPS"
  value       = module.ec2.public_ips
}
output "s3_bucker_arns" {
  description = "S3 BUCKET ARNS"
  value       = module.s3.bucket_arns
}
output "s3_bucker_names" {
  description = "S3 BUCKET NAMES"
  value       = module.s3.bucket_names
}
output "dynamodb_table_names" {
  description = "DYNAMODB TABLE NAMES"
  value       = module.dynamodb.table_names
}
output "dynamodb_table_arns" {
  description = "DYNAMODB TABLE ARNS"
  value       = module.dynamodb.table_arns
}

