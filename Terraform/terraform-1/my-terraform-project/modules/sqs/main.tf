module "lambda" {
  source = "../lambda" 
  SNS_TOPIC_ARN = module.sns.notifications_arn
}

resource "aws_sqs_queue" "message_queue" {
  name = "message-queue"
}

resource "aws_lambda_event_source_mapping" "lambda_to_sqs" {
  function_name = var.lambda_arn
  event_source_arn = aws_sqs_queue.message_queue.arn
  enabled = true
}