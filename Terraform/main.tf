resource "aws_instance" "instanciaEC2S3" {
  ami           = "ami-0453ec754f44f9a4a"  # AMI de Amazon Linux 64 bits
  instance_type = "t2.micro"
  key_name      = "instanciaEC2S3"        # Nombre del par de llaves SSH
  security_groups = ["instanciaEC2S3-security-group"]

  tags = {
    Name = "instanciaEC2S3"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx php php-fpm git
              service nginx start
              service php-fpm start
              EOF
}

resource "aws_security_group" "instanciaEC2S3-security-group" {
  name        = "instanciaEC2S3-security-group"
  description = "Allow HTTP and SSH"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir tráfico SSH desde cualquier lugar
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir tráfico HTTP desde cualquier lugar
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir todo el tráfico saliente
  }
}
