# Specify the AWS provider
# main file to write all the commands
provider "aws" {
  region = "us-east-1" # Specify your preferred region
}

# Security Group to Allow SSH, HTTP, and Custom Traffic
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH, HTTP, and Custom traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access (update for better security)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow custom traffic on port 3000
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

# Launch an EC2 Instance in the Default VPC
resource "aws_instance" "web_app" {
  ami           = "ami-0dba2cb6798deb6d8" # Replace with the AMI ID for your region
  instance_type = "t2.micro"
  key_name      = var.key_name # Name of the key pair for SSH access
  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "web-app-instance"
  }

}

# Get the Default VPC
data "aws_vpc" "default" {
  default = true
}
