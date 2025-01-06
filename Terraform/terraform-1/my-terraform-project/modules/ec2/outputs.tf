output "instance_id" {
  value = aws_instance.prueba_instance.id
}

output "instance_public_ip" {
  value = aws_instance.prueba_instance.public_ip
}

output "web_app_public_url" {
  value = aws_instance.prueba_instance.public_dns
  description = "URL pública de la instancia EC2 que ejecuta la aplicación web"
}
