output "SQS_QUEUE_ARN" {
  value = aws_sqs_queue.message_queue.arn
}

output "SQS_QUEUE_URL" {
  value = aws_sqs_queue.message_queue.url
}