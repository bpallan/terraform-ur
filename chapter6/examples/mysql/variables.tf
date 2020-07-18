variable "db_password_id" {
  description = "The password id for the database"
  type        = string
  default     = "mysql-master-password-stage"
}

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "example_database"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  default     = "admin"
}