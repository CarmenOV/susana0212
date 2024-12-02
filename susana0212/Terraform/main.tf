# Use data source to retrieve an Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# VPC - Puedes usar el mismo código para la VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-carmen"  # Personalizado para ti
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "int-gw-carmen"
  }
}

# Subnet pública
resource "aws_subnet" "public_subnet_carmen" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"  # Subred pública con el CIDR adecuado
  availability_zone       = "us-east-1a"  # Puedes cambiar la zona según tus necesidades
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-carmen"
  }
}

# Security Group (grupo de seguridad para la web)
resource "aws_security_group" "webserver_security_group" {
  name        = "webserver-sg-carmen"
  description = "Allow HTTP, HTTPS, and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Lanzar la instancia EC2 (Amazon Linux 2)
resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"  # O usa var.instance_type si prefieres una variable
  subnet_id              = aws_subnet.public_subnet_carmen.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.webserver_security_group.id]
  user_data              = file("command.sh")  # Asegúrate de tener este archivo 'command.sh' con los comandos de inicio

  tags = {
    Name = "web-instance-carmen"  # Nombre personalizado para la instancia
  }
}

# Output para mostrar la IP pública de la instancia EC2
output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}
