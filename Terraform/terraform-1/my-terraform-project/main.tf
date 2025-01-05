provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  ami_id = var.ami_id
}

module "sns" {
  source = "./modules/sns"
}

module "lambda" {
  source = "./modules/lambda"
  SNS_TOPIC_ARN = module.sns.notifications_arn
}

module "sg" {
  source = "./modules/sg"
}

module "sqs" {
  source = "./modules/sqs"
  lambda_arn = module.lambda.process_message_arn
}

module "vpc" {
  source = "./modules/vpc"
}