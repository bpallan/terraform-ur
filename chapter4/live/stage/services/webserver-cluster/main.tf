provider "aws" {
    region = "us-east-2"
}

module "webserver_cluster" {
    source = "../../../../modules/services/webserver-cluster"
    # example of pull module from github using tag!  
    # for some reason the double // after the base url is required
    # source = "github.com/brikis98/terraform-up-and-running-code//code/terraform/04-terraform-module/module-example/modules/services/webserver-cluster?ref=v0.1.0"

    cluster_name = "webservers-stage"
    db_remote_state_bucket = "ballan-terraform-state"
    db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
    instance_type = "t2.micro"
    min_size = 2
    max_size = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
    type = "ingress"
    security_group_id = module.webserver_cluster.alb_security_group_id

    from_port = 12345
    to_port = 12345
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

