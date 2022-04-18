resource "aws_lambda_function" "sayhello" {
  function_name = "sayhello"
  filename    = "${path.module}/lambda_function.zip"
  handler     = "lambda_function.lambda_handler"
  runtime     = "nodejs12.x"
  memory_size = 256
  timeout     = 10

  role = "${aws_iam_role.sayhellorole.arn}"
}

