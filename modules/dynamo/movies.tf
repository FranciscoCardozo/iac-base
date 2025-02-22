resource "aws_dynamodb_table" "movies_cinema" {
  name         = "movies_cinema_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "movie_id"
  range_key    = "movie_title" 

  attribute {
    name = "movie_id"
    type = "S"
  }

  attribute {
    name = "movie_title"
    type = "S"
  }

  tags = {
    Name        = "MoviesTable"
    Environment = "Dev"
  }
}
