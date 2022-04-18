resource "aws_lambda_function" "sayhello" {
  function_name = "sayhello"
  filename    = "${path.module}/lambda_function.zip"
  handler     = "lambda_function.lambda_handler"
  runtime     = "nodejs12.x"
  memory_size = 256
  timeout     = 10

  role = "${aws_iam_role.sayhellorole.arn}"
}

resource "aws_cloudwatch_log_group" "lambda-group" {
  name              = "/aws/lambda/${aws_lambda_function.sayhello.function_name}"
  retention_in_days = 14
}


resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.sayhellorole.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
