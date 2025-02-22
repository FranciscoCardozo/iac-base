output "request_table_name" {
  value = aws_dynamodb_table.request_cinema.name
}

output "movies_table_name" {
  value = aws_dynamodb_table.movies_cinema.name
}

output "room1_table_name" {
  value = aws_dynamodb_table.room1_cinema.name
}

output "room2_table_name" {
  value = aws_dynamodb_table.room2_cinema.name
}