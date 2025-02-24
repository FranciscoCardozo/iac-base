resource "aws_dynamodb_table" "request_cinema" {
  name         = "request_cinema_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "uuid"
  range_key    = "date" 

  attribute {
    name = "uuid"
    type = "S"
  }

  attribute {
    name = "date"
    type = "S"
  }

  tags = {
    Name        = "request_cinema_table"
    Environment = "Dev"
  }
}
