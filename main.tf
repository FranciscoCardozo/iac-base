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

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "s3-app-cinema"
  environment        = "prod"
  versioning_enabled = true
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
  aws_region        = "us-east-1"
  aws_account_id    = var.accound_id
  api_execution_arn = module.apigateway.cinema_execution_arn
}

module "cloudfront" {
  source           = "./modules/cloudfront"
  cloudfront_name  = "cinema-digital"
  s3_bucket_domain = module.s3.bucket_regional_domain_name
  s3_origin_id     = "S3Origin"
  environment      = "prod"
}

module "apigateway" {
  source     = "./modules/apigateway"
  api_name   = "api-cinema"
  oas_file   = "./api.json"
  stage_name = "prod"
  lambda_arn_cinema = module.lambda.cinema_arn
  lambda_name_cinema = "Lambda_Cinema_Function"
  lambda_role_name_cinema = module.lambda.cinema_role_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "api_url" {
  value = module.apigateway.cinema_url
}