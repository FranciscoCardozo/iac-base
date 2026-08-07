locals {
  lambda_name = "Lambda_Assessments_Function"
}
resource "aws_lambda_function" "assessments_function" {
  function_name    = local.lambda_name
  role             = aws_iam_role.lambda_role_assessments.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = var.lambda_zip
  source_code_hash = filebase64sha256(var.lambda_zip)
}

# **🔹 Rol IAM para Lambda**
resource "aws_iam_role" "lambda_role_assessments" {
  name = "${local.lambda_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# **🔹 Permisos para Lambda**
resource "aws_iam_policy_attachment" "lambda_basic_execution_assessments" {
  name       = "lambda-basic-execution"
  roles      = [aws_iam_role.lambda_role_assessments.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# **🔹 Output para exportar ARN de Lambda**
output "lambda_arn_assessments" {
  value = aws_lambda_function.assessments_function.arn
}
