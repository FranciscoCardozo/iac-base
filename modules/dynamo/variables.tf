variable "table_names" {
  type = map(string)
  default = {
    assessments = "assessments_table"
  }
}
