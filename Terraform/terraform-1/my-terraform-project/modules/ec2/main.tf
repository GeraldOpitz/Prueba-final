module "sg" {
  source = "../sg"
}
resource "aws_instance" "prueba_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  security_groups = [module.sg.web_sg_name]

  tags = {
    Name = "PruebaFinal"
  }
}