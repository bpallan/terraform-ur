provider "aws" {
    region = "us-west-2"
}

module "asg" {
    source = "../../modules/cluster/asg-rolling-deploy"
    cluster_name = var.cluster_name
    ami = "ami-0edf3b95e26a682df"
    instance_type = "t2.micro"
    min_size = 1
    max_size = 1
    enable_autoscaling = false
    subnet_ids = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

