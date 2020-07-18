variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default = "example"
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  type        = string
  default     = "ballan-terraform-state"
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  default        = "stage/data-stores/mysql/terraform.tfstate"
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default = 1
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default = 1
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default = false
}
