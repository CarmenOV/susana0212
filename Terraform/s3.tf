# Crear un Bucket en S3
resource "aws_s3_bucket" "mi_bucket_carmen" {
  bucket = "carmen-bucket-2024"  # Asegúrate de que el nombre sea único
  force_destroy = true  # Permite destruir el bucket incluso si tiene objetos

  tags = {
    Name        = "carmen-bucket"
    Environment = "Dev"
  }
}

# Configurar el acceso público para el Bucket (si se desea)
resource "aws_s3_bucket_public_access_block" "bucket_public_block_carmen" {
  bucket = aws_s3_bucket.mi_bucket_carmen.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  depends_on = [aws_s3_bucket.mi_bucket_carmen]
}

# Aplicar la política de acceso pública al Bucket
resource "aws_s3_bucket_policy" "bucket_policy_carmen" {
  bucket = aws_s3_bucket.mi_bucket_carmen.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.mi_bucket_carmen.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.bucket_public_block_carmen]
}

# Configurar el Bucket como un sitio web estático
resource "aws_s3_bucket_website_configuration" "s3_pagina_carmen" {
  bucket = aws_s3_bucket.mi_bucket_carmen.id

  index_document {
    suffix = "index.html"
  }

  # Si tienes una página de error personalizada, descomenta la línea siguiente:
  # error_document {
  #   key = "error.html"
  # }
}
