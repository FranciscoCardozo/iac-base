resource "aws_dynamodb_table" "room1_cinema" {
  name         = "rooms_cinema_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "room_id"         

  attribute {
    name = "room_id"
    type = "S"
  }

  tags = {
    Name        = "room1Table"
    Environment = "Dev"
  }
}
