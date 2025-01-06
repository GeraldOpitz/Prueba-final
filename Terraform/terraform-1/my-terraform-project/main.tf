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
  SQS_QUEUE_ARN = module.sqs.message_queue_arn
}

module "sqs" {
  source = "./modules/sqs"
  lambda_arn = module.lambda.process_message_arn
}