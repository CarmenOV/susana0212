output "instance_ip" {
  description = "La dirección IP pública de la instancia EC2"
  value       = aws_instance.instanciaEC2S3.public_ip
}
