resource "aws_key_pair" "aws_ec2_ssh" {
  key_name   = "${var.project_name}-key-pair"
  public_key = file("~/.ssh/mail_server_id_rsa.pub")
  tags       = var.tags
}