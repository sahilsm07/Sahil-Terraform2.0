terraform {
  backend "s3" {
    bucket = "sahilsprintbucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "Sahil-table"
  }
}