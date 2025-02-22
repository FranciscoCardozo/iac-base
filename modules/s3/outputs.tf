output "bucket_name" {
  value = aws_s3_bucket.bucket_cinema.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket_cinema.arn
}
