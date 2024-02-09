data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

# EC2 Network interface
resource "aws_network_interface" "this" {
  subnet_id       = aws_subnet.private.0.id
  private_ips     = var.private_ip
  security_groups = [aws_security_group.ec2.id]

  tags = {
    Name = "ec2-jjung"
  }
}

# EC2 instance resource
resource "aws_instance" "this" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name = var.key_name
  user_data = templatefile("user_data.tftpl", {name = "sysadmin"})

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }

  # root disk
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "50"
  }

    tags = {
      Name = "ec2-jjung"
    }
  }
