variable "region" {
  description = "La región donde se desplegará la instancia"
  default     = "us-east-1"
}

variable "ami" {
  description = "ID de la AMI para la instancia EC2"
  default     = "ami-0453ec754f44f9a4a"  # AMI de Amazon Linux 64 bits
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre del par de claves SSH"
  default     = "instanciaEC2S3"
}

variable "security_group_name" {
  description = "Nombre del grupo de seguridad"
  default     = "instanciaEC2S3-security-group"
}

variable "instance_name" {
  description = "Nombre de la instancia EC2"
  default     = "instanciaEC2S3"
}
