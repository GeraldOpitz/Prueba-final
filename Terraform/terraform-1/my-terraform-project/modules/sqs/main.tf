resource "aws_sqs_queue" "message_queue" {
  name = "message-queue"
}

resource "aws_lambda_event_source_mapping" "lambda_to_sqs" {
  event_source_arn = aws_sqs_queue.message_queue.arn
  function_name = aws_lambda_function.process_message.arn
}