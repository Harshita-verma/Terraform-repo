


resource "aws_key_pair" "key" {
  key_name   = "harsh_key89"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "webapp_instance" {
  ami             = var.ami_id
  instance_type   = "t2.medium"
  key_name        = aws_key_pair.key.key_name
  security_groups = [aws_security_group.web_app.id]
  subnet_id     = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  tags = {
    Name = "webapp_instance"
  }
}


resource "aws_security_group" "web_app" {
  name        = "web_app"
  description = "security group"
  vpc_id = aws_vpc.Main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_app"
  }
}


