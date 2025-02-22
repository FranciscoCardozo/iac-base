resource "aws_dynamodb_table" "room1_cinema" {
  name         = "room1_cinema_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "room_id"         
  range_key    = "reservation_time" 

  attribute {
    name = "room_id"
    type = "S"
  }

  attribute {
    name = "reservation_time"
    type = "S"
  }

  attribute {
    name = "reservation_time"
    type = "S"
  }


  tags = {
    Name        = "room1Table"
    Environment = "Dev"
  }
}
