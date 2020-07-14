# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "db_password_id" {
  description = "The password id for the database"
  type        = string
  default     = "mysql-master-password-stage" # should create unique for prod
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = "example_database_prod"
}
