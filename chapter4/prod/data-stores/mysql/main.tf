provider "aws" {
    region = "us-west-2"
}

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t2.micro"
    name = "example_database"
    username = "admin"
    skip_final_snapshot = true

    # secrets manager example
    password = data.aws_secretsmanager_secret_version.db_password.secret_string
}

data "aws_secretsmanager_secret_version" "db_password" {
    secret_id = "mysql-master-password-stage" # should be prod but don't feel like creating multiple secrets for demo
}

terraform {
    backend "s3" {
        bucket = "ballan-terraform-state"
        key = "prod/data-stores/mysql/terraform.tfstate"
        region = "us-west-2"

        dynamodb_table = "ballan-locks"
        encrypt = true
    }
}