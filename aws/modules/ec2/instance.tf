resource "aws_instance" "aws_ec2_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  associate_public_ip_address = true
  key_name                    = aws_key_pair.aws_ec2_ssh.id
  vpc_security_group_ids      = [aws_security_group.aws_ec2_instance_sg.id]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ec2"
    }
  )
}