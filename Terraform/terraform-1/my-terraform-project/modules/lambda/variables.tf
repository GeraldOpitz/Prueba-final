variable "SNS_TOPIC_ARN" {
  type = string
  default = aws_sns_topic.notifications.arn
}