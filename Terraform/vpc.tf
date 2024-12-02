# main.tf

provider "aws" {
  region = "us-east-1"  # Cambia la región si es necesario
}

# Crear la VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-carmen"  # Nombre personalizado para la VPC
  }
}

# Crear la puerta de enlace de Internet (Internet Gateway)
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "int-gw-carmen"  # Nombre personalizado para la puerta de enlace
  }
}

# Crear la subred pública
resource "aws_subnet" "public_subnet_carmen" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-carmen"  # Nombre personalizado para la subred
  }
}

# Crear la tabla de rutas pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public-route-table-carmen"  # Nombre personalizado para la tabla de rutas
  }
}

# Asociar la subred pública con la tabla de rutas
resource "aws_route_table_association" "public_subnet_carmen_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_carmen.id
  route_table_id = aws_route_table.public_route_table.id
}
