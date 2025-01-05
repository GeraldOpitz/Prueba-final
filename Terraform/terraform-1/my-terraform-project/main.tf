provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  ami_id = var.ami_id
}

module "lambda" {
  source = "./modules/lambda"
  SNS_TOPIC_ARN = aws_sns_topic.notifications.arn
}

module "sg" {
  source = "./modules/sg"
}

module "sns" {
  source = "./modules/sns"
}

module "sqs" {
  source = "./modules/sqs"
}

module "vpc" {
  source = "./modules/vpc"
}