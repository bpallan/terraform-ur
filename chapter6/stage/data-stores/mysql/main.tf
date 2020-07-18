provider "aws" {
    region = "us-west-2"
}

terraform {
  backend "s3" {

    bucket         = "ballan-terraform-state"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ballan-locks"
    encrypt        = true

  }
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = data.aws_secretsmanager_secret_version.db_password.secret_string
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = var.db_password_id
}

