variable "table_names" {
  type = map(string)
  default = {
    request = "request_cinema_table"
    movies  = "movies_cinema_table"
    room1   = "room1_cinema_table"
    room2   = "room2_cinema_table"
  }
}
