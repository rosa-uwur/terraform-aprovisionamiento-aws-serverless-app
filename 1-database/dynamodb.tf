resource "aws_dynamodb_table" "serverless-database" {
  name           = "moviesdb-${var.sandbox_id}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "MovieID"

  attribute {
    name = "MovieID"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "item" {
  for_each = {
    movie001 = {
      name    = "Sherk"
      actors  = "Cameron Diaz, Mike Myers and Eddie Morphy"
      release = "2008"
    },
    movie002 = {
      name    = "The Avengers"
      actors  = "Robert Downy Jr., Scarlett Johansson and Chris Evans"
      release = "2012"
    },
    movie003 = {
      name    = "Fight Club"
      actors  = "Brad Pitt, Edward Norton and Helena Bonham Carter"
      release = "1999"
    },
    movie004 = {
      name    = "The Princess Diaries"
      actors  = "Anne Hathaway, Julie Andrews and Heather Matarazzo"
      release = "2001"
    },
    movie005 = {
      name    = "The Devil Wears Prada"
      actors  = "Meryl Streep, Anne Hathaway and Emily Blunt"
      release = "2006"
    }
  }
  table_name = aws_dynamodb_table.serverless-database.name
  hash_key   = aws_dynamodb_table.serverless-database.hash_key

  item = <<ITEM
{
  "MovieID": {"S": "${each.key}"},
  "Actors": {"S": "${each.value.actors}"},
  "MovieName": {"S": "${each.value.name}"},
  "ReleaseDate": {"S": "${each.value.release}"}
}
ITEM
}