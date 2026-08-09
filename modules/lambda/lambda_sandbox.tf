locals {
  lambda_name_sandbox = var.sandbox_lambda_name
}

data "archive_file" "bootstrap_sandbox" {
  type        = "zip"
  output_path = "${path.root}/.terraform/lambda-sandbox-bootstrap.zip"

  source {
    filename = "index.js"
    content  = "exports.handler = async () => ({ statusCode: 200, body: JSON.stringify({ message: \"Lambda pending deployment\" }) });"
  }
}

resource "aws_iam_role" "lambda_role_sandbox" {
  name = "${local.lambda_name_sandbox}-role"

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

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_sandbox" {
  role       = aws_iam_role.lambda_role_sandbox.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access_sandbox" {
  role       = aws_iam_role.lambda_role_sandbox.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy" "ec2_access_sandbox" {
  name = "${local.lambda_name_sandbox}-ec2-access"
  role = aws_iam_role.lambda_role_sandbox.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeNetworkInterfaces"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances"
        ]
        Resource = var.ec2_instance_arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "dynamodb_sandbox" {
  name = "${local.lambda_name_sandbox}-dynamodb"
  role = aws_iam_role.lambda_role_sandbox.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "dynamodb:Query",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ]
      Resource = var.dynamodb_table_arn
    }]
  })
}

resource "aws_lambda_function" "sandbox_function" {
  function_name    = local.lambda_name_sandbox
  role             = aws_iam_role.lambda_role_sandbox.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = data.archive_file.bootstrap_sandbox.output_path
  source_code_hash = data.archive_file.bootstrap_sandbox.output_base64sha256

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.security_group_id]
  }

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}

output "lambda_arn_sandbox" {
  value = aws_lambda_function.sandbox_function.arn
}
