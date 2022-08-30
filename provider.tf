provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key

}


terraform {
  backend "s3" {
    bucket = "harshitav18"
    key    = "terraform.tfstate"
    region = "eu-west-1"

  }
}