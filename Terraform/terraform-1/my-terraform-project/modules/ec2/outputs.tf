output "instance_id" {
  value = aws_instance.prueba_instance.id
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}