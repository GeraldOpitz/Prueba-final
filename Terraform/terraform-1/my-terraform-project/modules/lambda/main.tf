resource "aws_lambda_function" "process_message" {
    function_name = "processMessage"
    filename = "lambda.zip"
    handler = "index.handler"
    runtime = "nodejs18.x"
    role = aws_iam_role.lambda_exec.arn

    environment {
      variables = {
        SNS_TOPIC_ARN = var.SNS_TOPIC_ARN
      }
    }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            }
        }
    ]
  })
}

resource "aws_iam_policy" "sns_publish_policy" {
    name        = "SNSPublishPolicy"
    description = "Policy to allow Lambda to publish to SNS"
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action   = "sns:Publish",
                Effect   = "Allow",
                Resource = var.SNS_TOPIC_ARN
            }
        ]
    })
}

resource "aws_iam_policy" "lambda_sqs_policy" {
  name        = "lambda_sqs_policy"
  description = "Policy to allow Lambda to access SQS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility",

        ],
        Effect   = "Allow",
        Resource = var.SQS_QUEUE_ARN
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_attachment" {
    role       = aws_iam_role.lambda_exec.name
    policy_arn = aws_iam_policy.lambda_sqs_policy.arn

}
