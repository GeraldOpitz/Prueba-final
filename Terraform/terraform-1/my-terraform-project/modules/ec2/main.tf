module "vpc" {
  source = "../vpc"
}
resource "aws_instance" "prueba_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  security_groups = var.security_groups

  tags = {
    Name = "PruebaFinal"
  }
}