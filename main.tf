terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  vpc_name            = "mi-vpc"
  private_subnet_cidr = "10.0.1.0/24"
  availability_zone   = "us-east-1b"
}

module "dynamo" {
  source = "./modules/dynamo"
}
module "lambda" {
  source            = "./modules/lambda"
  lambda_name       = "lambda_cinema"
  lambda_zip        = "lambda.zip"
  subnet_ids        = [module.vpc.private_subnet_id]
  security_group_id = module.vpc.lambda_sg_id
}

module "apigateway" {
  source     = "./modules/apigateway"
  api_name   = "api-cinema"
  oas_file   = "${path.module}/api.yaml"
  stage_name = "prod"
  lambda_arn = module.lambda.lambda_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "api_url" {
  value = module.apigateway.api_url
}