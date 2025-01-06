provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  ami_id = var.ami_id
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  security_groups = [module.sg.web_sg_id]
}

module "ecr" {
  source = "./modules/ecr"
}

module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "sns" {
  source = "./modules/sns"
}

module "lambda" {
  source = "./modules/lambda"
  SNS_TOPIC_ARN = module.sns.notifications_arn
  SQS_QUEUE_ARN = module.sqs.SQS_QUEUE_ARN
  SQS_QUEUE_URL = module.sqs.SQS_QUEUE_URL
}

module "sqs" {
  source = "./modules/sqs"
  lambda_arn = module.lambda.process_message_arn
}