locals {
  env_config = {
    dev = {
      instance_count = 2
      bucket_count   = 1
      table_count    = 1
    }
    prod = {
      instance_count = 3
      bucket_count   = 2
      table_count    = 2
    }
  }

  current = lookup(local.env_config, terraform.workspace, local.env_config["dev"])

  common_tags = {
    Environment = terraform.workspace
    ManagedBy   = "terraform"
    Project     = "terra-ansible-project"
  }
}





# Ec2 module
module "ec2" {
  source = "./modules/ec2"

  env             = terraform.workspace
  instance_count  = local.current.instance_count
  ami             = var.ami
  instance_type   = var.instance_type
  volume_size     = var.volume_size
  volume_type     = var.volume_type
  key_public_path = var.key_public_path
  common_tags     = local.common_tags
}


# S3 module
module "s3" {
  source       = "./modules/s3"
  env          = terraform.workspace
  bucket_count = local.current.bucket_count
  common_tags  = local.common_tags
}


# DynamoDB module
module "dynamodb" {
  source      = "./modules/dynamodb"
  env         = terraform.workspace
  table_count = local.current.table_count
  common_tags = local.common_tags
}
