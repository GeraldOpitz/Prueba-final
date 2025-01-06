module "sg" {
  source = "../sg"
}

module "vpc" {
  source = "../vpc"
}
resource "aws_instance" "prueba_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_id
  security_groups = [module.sg.web_sg_name]

  tags = {
    Name = "PruebaFinal"
  }
}