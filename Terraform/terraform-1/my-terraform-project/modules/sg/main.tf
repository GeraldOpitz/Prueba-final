resource "aws_security_group" "web_sg" {
  name = "web-sg"
  description = "Allow HTTP and SSH"

  ingress = [
    {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = true
    },
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SHH traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = true
    }
  ]
}