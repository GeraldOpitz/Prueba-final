output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
  sensitive = false
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}