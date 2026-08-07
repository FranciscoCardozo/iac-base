resource "aws_dynamodb_table" "assessments_table" {
  name         = "assessments_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PartitionKey"
  range_key    = "SortKey"


  tags = {
    Name        = "AssessmentsTable"
    Environment = "Production"
  }
}
