locals {
  lambda_name = var.lambda_name
}

data "archive_file" "bootstrap" {
  type        = "zip"
  output_path = "${path.root}/.terraform/lambda-bootstrap.zip"

  source {
    filename = "index.js"
    content  = "exports.handler = async () => ({ statusCode: 200, body: JSON.stringify({ message: \"Lambda pending deployment\" }) });"
  }
}

resource "aws_iam_role" "lambda_role_assessments" {
  name = "${local.lambda_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_assessments" {
  role       = aws_iam_role.lambda_role_assessments.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "assessments_function" {
  function_name    = local.lambda_name
  role             = aws_iam_role.lambda_role_assessments.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.bootstrap.output_path
  source_code_hash = data.archive_file.bootstrap.output_base64sha256

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}

output "lambda_arn_assessments" {
  value = aws_lambda_function.assessments_function.arn
}
