module "sqs" {
  source = "../sqs"
}
resource "aws_sns_topic" "notifications" {
  name = "notifications"
}

resource "aws_sqs_queue" "message_queue" {
  name = "message-queue"
}

resource "aws_sns_topic_subscription" "sns_to_sqs" {
    topic_arn = aws_sns_topic.notifications.arn
    protocol  = "sqs"
    endpoint  = module.sqs.message_queue_arn
}

resource "aws_sqs_queue_policy" "sqs_policy" {
    queue_url = aws_sqs_queue.message_queue.id
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect    = "Allow",
                Principal = "*",
                Action    = "sqs:SendMessage",
                Resource  = aws_sqs_queue.message_queue.arn,
                Condition = {
                    ArnEquals = {
                        "aws:SourceArn": aws_sns_topic.notifications.arn
                    }
                }
            }
        ]
    })
}
