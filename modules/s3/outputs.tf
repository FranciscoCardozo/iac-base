output "bucket_name" {
  value = aws_s3_bucket.bucket_cinema.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket_cinema.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket_cinema.bucket_regional_domain_name
}

output "bucket_lambda_name" {
  value = aws_s3_bucket.bucket_lambda.id
}


output "bucket_lambda_arn" {
  value = aws_s3_bucket.bucket_lambda.arn
}