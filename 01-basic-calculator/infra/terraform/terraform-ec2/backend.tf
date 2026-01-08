terraform {
  backend "s3" {
    bucket         = "terraform-state-projcalc"
    key            = "terraform/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
