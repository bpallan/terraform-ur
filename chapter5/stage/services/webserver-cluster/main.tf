provider "aws" {
    region = "us-west-2"
}

terraform {
  backend "s3" {

    bucket         = "ballan-terraform-state"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "ballan-locks"
    encrypt        = true
  }
}

module "webserver_cluster" {
    source = "../../../modules/services/webserver-cluster"
    # example of pull module from github using tag!  
    # for some reason the double // after the base url is required
    # source = "github.com/brikis98/terraform-up-and-running-code//code/terraform/04-terraform-module/module-example/modules/services/webserver-cluster?ref=v0.1.0"

    cluster_name = var.cluster_name
    db_remote_state_bucket = var.db_remote_state_bucket
    db_remote_state_key = var.db_remote_state_key
    instance_type = "t2.micro"
    min_size = 2
    max_size = 2
    enable_autoscaling = false
}

resource "aws_security_group_rule" "allow_testing_inbound" {
    type = "ingress"
    security_group_id = module.webserver_cluster.alb_security_group_id

    from_port = 12345
    to_port = 12345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
