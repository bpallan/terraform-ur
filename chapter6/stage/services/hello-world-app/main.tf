provider "aws" {
    region = "us-west-2"
}

terraform {
  backend "s3" {

    bucket         = "ballan-terraform-state"
    key            = "stage/services/hello-world-app/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ballan-locks"
    encrypt        = true

  }
}

module "hello_world_app" {
    source = "../../../modules/services/hello-world-app"

    server_text = "New server text"
    environment = "stage"
    db_remote_state_bucket = "ballan-terraform-state"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    min_size = 2
    max_size = 2
    enable_autoscaling = false
}

