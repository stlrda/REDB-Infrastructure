#METADATA VARIABLES----------------------
cluster_name = "stl-rda-airflow"
tags = {
    "Project" = "airflow"
    "Owner" = "STLRDA"
  }


#ADMINISTRATION AND CREDENTIAL VARIABLES------------------
aws_region = "us-east-1"
aws_profile = "rda_umsl"
ec2_keypair_name = "jfl_airflow"
public_key_path = "/home/jonathan/.ssh/jfl_airflow.pub"
private_key_path = "/home/jonathan/.ssh/jfl_airflow.pem"
admin_email = "jonathanleek@umsl.edu"
admin_username = "jonathanleek"
admin_password = "Ygvb43gHLYi6NANvL90L8yqy6Bo8LWd9"
fernet_key = "dIC66V4LWTDB5MF0Ah7OxhINY8zflP3MUHJEWhpfPYk="

#AIRFLOW CONFIG VARIABLES------------------------------
time_zone = "America/Chicago"
load_examples = "True"

#EC2 VARIABLES (APPLY TO ALL EC2 INSTANCES UNLESSS OTHERWISE SPECIFIED)--------------------------
webserver_instance_type = "t3.micro"
scheduler_instance_type = "t3.micro"
worker_instance_type = "t3.small"
number_of_workers  = 1

#DB VARIABLES------------------------------------
db_instance_type = "db.t2.micro"
db_dbname = "airflow"
db_username = "jonathanleek"
db_password = "Yws82fZFRG6hH2jhRiqmillN94fKRqFhAGD5wEAGXxo0Ey2tza"

#GIT VARIABLES--------------------------------------
dag_git_repository_url="https://github.com/stlrda/REDB-Workflows"
dag_git_repository_directory="python"
dag_git_repository_branch="master"