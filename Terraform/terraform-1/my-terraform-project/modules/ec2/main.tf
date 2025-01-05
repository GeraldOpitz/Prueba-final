resource "aws_instance" "prueba_instance" {
  ami = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "PruebaFinal"
  }

  security_groups = [aws_security_group.web_sg.name]
}