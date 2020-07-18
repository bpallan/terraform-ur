provider "aws" {
  region = "us-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

module "hello-world-app" {
    source = "../../modules/services/hello-world-app"

    environment = var.environment
    min_size = var.min_size
    max_size = var.max_size
    enable_autoscaling = var.enable_autoscaling
    db_remote_state_bucket = var.db_remote_state_bucket
    db_remote_state_key = var.db_remote_state_key
}