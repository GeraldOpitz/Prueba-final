output "SQS_QUEUE_ARN" {
  value = aws_sqs_queue.message_queue.arn
}
