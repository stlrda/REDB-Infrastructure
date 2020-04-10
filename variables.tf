#METADATA VARIABLES----------------------
variable "cluster_name" {
  description = "Used to name resources created throughout AWS"
  type        = string
}

variable "tags" {
  description = "Tags applied to all Airflow related objects"
  type        = map
  default = {
    "Project" = "Airflow"
  }
}

#AIRFLOW CONFIG VARIABLES-----------------------
variable "time_zone" {
  description = "Default timezone in case supplied date times are naive can be utc (default), system, or any IANA timezone string (e.g. Europe/Amsterdam)"
  type = string
  default = "utc"
}

variable "load_examples" {
  description = "Loads example dags and connections into Airflow. Useful for starting/testing, not recommended"
  type = string
  default = "True"
}
#ADMINISTRATION AND CREDENTIAL VARIABLES------------------
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Profile from AWS credential file to be used"
  type        = string
  default     = "default"
}

variable "ec2_keypair_name" {
  description = "Name of keypair used to access ec2 instances"
  type        = string
  default     = "Airflow_key"
}

variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to use for ec2 instances."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Enter the path to the SSH Private Key to use for ec2 instances."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "admin_email" {
  description = "Email address for the administrator for the airflow cluster"
  type = string
}

variable "admin_username" {
  description = "Username for the administrator for the airflow cluster"
  type = string
}

variable "admin_password" {
  description = "Password for teh adminstrator for the airflow cluster"
}

#EC2 VARIABLES (APPLY TO ALL EC2 INSTANCES UNLESSS OTHERWISE SPECIFIED)--------------------------
variable "webserver_instance_type" {
  description = "Instance type for the Airflow Webserver."
  type        = string
  default     = "t3.micro"
}

variable "scheduler_instance_type" {
  description = "Instance type for the Airflow Scheduler."
  type        = string
  default     = "t3.micro"
}

variable "worker_instance_type" {
  description = "Instance type for the Airflow workers."
  type        = string
  default     = "t3.small"
}

variable "number_of_workers" {
  description = "Number of workers for Airflow Cluster"
  type        = string
  default     = 1
}

#AIRFLOW DB VARIABLES------------------------------------
variable "db_instance_type" {
  description = "Instance type for PostgreSQL database"
  type        = string
  default     = "db.t2.micro"
}

variable "db_dbname" {
  description = "PostgreSQL database name"
  type        = string
  default     = "airflow"
}

variable "db_username" {
  description = "PostgreSQL database username"
  type        = string
  default     = "airflow"
}

variable "db_password" {
  description = "PostgreSQL database password"
  type        = string
}

variable "fernet_key" {
  description = "Key for encrypting data in the database - see Airflow docs."
  type = string
}

#GIT VARIABLES------------------------------------
variable "dag_git_repository_url" {
  description = "Publicly available github repository url of dag repository."
  type = string
}

variable "dag_git_repository_directory" {
  description = "Sub directory of folder in repository containing DAGs."
  type = string
}

variable "dag_git_repository_branch" {
  description = "Branch of repository to pull every 5 minutes."
  type = string
}

#REDB VARIABLES-----------------------------------------
variable "redb_db_name" {
  description = "Name of ETL target database"
  type = string
}

variable "redb_db_instance_type" {
  description = "Instance type of ETL target database"
  type = string
  default = "t2.large"
}

variable "redb_db_username" {
  description = "Master Username for ETL target database"
  type = string
}

variable "redb_db_password" {
  description = "Master password for ETL target database"
  type = string
}

