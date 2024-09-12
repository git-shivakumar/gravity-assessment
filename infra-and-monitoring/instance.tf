####### Security group #########

resource "aws_security_group" "web-sg" {
  vpc_id = aws_vpc.gravity-vpc.id
  name   = "web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}


####### Web server Instance ###########
resource "aws_instance" "public-instance" {
  ami           = "ami-0522ab6e1ddcc7055"
  instance_type = "t3a.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  associate_public_ip_address = true
  key_name = "demo"
  user_data = file("userdata.tpl")
  root_block_device {
    volume_type = "gp3"
    volume_size = 20 # Adjust volume size as needed
  }
  tags = {
    Name = "public-web-server"
  }
}
