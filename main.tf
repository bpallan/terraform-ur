provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "example" {
    ami             = "ami-0edf3b95e26a682df"
    instance_type   = "t2.micro" 

    tags = {
        Name = "terraform-example"
    }
}

