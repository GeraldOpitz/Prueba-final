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

resource "aws_iam_role_policy_attachment" "lambda_sns_publish" {
    role       = aws_iam_role.lambda_exec.name
    policy_arn = aws_iam_policy.sns_publish_policy.arn
}
