provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "example" {
    ami = "ami-0edf3b95e26a682df"
    instance_type = "t2.micro"
}

terraform {
    backend "s3" {
        bucket = "ballan-terraform-state"
        key = "workspaces-example/terraform.tfstate"
        region = "us-west-2"

        dynamodb_table = "ballan-locks"
        encrypt = true
    }
}