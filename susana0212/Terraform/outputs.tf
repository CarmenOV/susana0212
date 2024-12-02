output "instance_ip" {
  description = "La dirección IP pública de la instancia EC2"
  value       = aws_instance.instanciaEC2S3.public_ip
}
output "instance_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.ec2_instance.public_ip
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.vpc.id
}

output "subnet_id" {
  description = "ID de la subred pública"
  value       = aws_subnet.public_subnet_carmen.id
}

output "ec2_instance_id" {
  description = "ID de la instancia EC2"
  value       = aws_instance.ec2_instance.id
}
