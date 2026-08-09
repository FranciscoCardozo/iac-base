terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


module "vpc" {
  source                   = "./modules/vpc"
  cidr_block               = "10.0.0.0/16"
  vpc_name                 = "mi-vpc"
  private_subnet_cidr      = "10.0.1.0/24"
  availability_zone        = "us-east-1b"
  public_subnet_cidr       = "10.0.2.0/24"
  public_availability_zone = "us-east-1b"
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  instance_type = "t2.medium"
  instance_name = "ubuntu-2204"
}

module "s3" {
  source             = "./modules/s3"
  bucket_name        = "s3-app-assessments"
  environment        = "prod"
  versioning_enabled = true
  cloudfront_id      = module.cloudfront.cloudfront_id
}


module "dynamo" {
  source = "./modules/dynamo"
}
module "lambda" {
  source              = "./modules/lambda"
  lambda_name         = "lambda_assessments"
  sandbox_lambda_name = "lambda_sandbox"
  subnet_ids          = [module.vpc.private_subnet_id]
  security_group_id   = module.vpc.lambda_sg_id
  aws_region          = "us-east-1"
  aws_account_id      = var.accound_id
  dynamodb_table_arn  = module.dynamo.assessments_table_arn
  ec2_instance_arn    = module.ec2.instance_arn
}

module "cloudfront" {
  source           = "./modules/cloudfront"
  cloudfront_name  = "cinema-digital"
  s3_bucket_domain = module.s3.bucket_regional_domain_name
  s3_origin_id     = "S3Origin"
  environment      = "prod"
}

module "apigateway" {
  source                  = "./modules/apigateway"
  api_name                = "api-assessments"
  oas_file                = "./Api_Assesstments.json"
  stage_name              = "prod"
  lambda_arn_assessments  = module.lambda.assessments_arn
  lambda_name_assessments = "lambda_assessments"
  lambda_arn_sandbox      = module.lambda.lambda_arn_sandbox
  lambda_name_sandbox     = "lambda_sandbox"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "api_url" {
  value = module.apigateway.assessments_url
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}