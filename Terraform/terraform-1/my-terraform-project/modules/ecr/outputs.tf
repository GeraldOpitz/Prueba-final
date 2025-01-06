output "ecr_repository_url" {
  value = "aws_ecr_repository.prueba_final_repo.repository_url"
}

output "ecr_data_json" {
  value = jsonencode({
    ecr_repository_url = aws_ecr_repository.prueba_final_repo.repository_url
  })
  sensitive = false
}