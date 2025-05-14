resource "aws_security_group" "aws_ec2_instance_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for Mailcow."

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-machine-sg"
    }
  )
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

locals {
  my_ip_cidr = "${trim(data.http.my_ip.response_body, "\n ")}/32"
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_ssh_access" {
  security_group_id = aws_security_group.aws_ec2_instance_sg.id

  cidr_ipv4   = local.my_ip_cidr
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_http_access" {
  security_group_id = aws_security_group.aws_ec2_instance_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_https_access" {
  security_group_id = aws_security_group.aws_ec2_instance_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_smtp_access" {
  security_group_id = aws_security_group.aws_ec2_instance_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 25
  ip_protocol = "tcp"
  to_port     = 25
}

# resource "aws_vpc_security_group_ingress_rule" "allow_inbound_smtp_ssl_access" {
#   security_group_id = aws_security_group.aws_ec2_instance_sg.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 465
#   ip_protocol = "tcp"
#   to_port     = 465
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_inbound_authenticated_smtp_access" {
#   security_group_id = aws_security_group.aws_ec2_instance_sg.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 587
#   ip_protocol = "tcp"
#   to_port     = 587
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_inbound_imap_ssl_access" {
#   security_group_id = aws_security_group.aws_ec2_instance_sg.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 993
#   ip_protocol = "tcp"
#   to_port     = 993
# }

resource "aws_vpc_security_group_egress_rule" "allow_outbound_all_traffic" {
  security_group_id = aws_security_group.aws_ec2_instance_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}