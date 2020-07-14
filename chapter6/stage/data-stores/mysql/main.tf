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

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    name = var.db_name
    username = "admin"
    skip_final_snapshot = true

    # secrets manager example
    password = data.aws_secretsmanager_secret_version.db_password.secret_string
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = var.db_password_id
}
