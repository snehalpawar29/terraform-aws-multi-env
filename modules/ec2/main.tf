#key-pair
resource "aws_key_pair" "this" {
  key_name   = "${var.env}-multi-env-key"
  public_key = file(var.key_public_path)
}
#vpc
resource "aws_default_vpc" "default" {

}

#security-group
resource "aws_security_group" "this" {
  name        = "${var.env}-multi-env-sg"
  vpc_id      = aws_default_vpc.default.id
  description = "ALLOW SSH & HTTP inbound, all outbound  - ${var.env}"
  tags = merge(var.common_tags, {
    Name = "${var.env}-multi-env-sg"
  })
}
#sg-rules
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#ec2_instance
resource "aws_instance" "this" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.this.id]
  depends_on             = [aws_security_group.this, aws_key_pair.this, aws_key_pair.this]
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = merge(var.common_tags, {
    Name = "${var.env}-terra-server-${count.index + 1}"
  })
}
