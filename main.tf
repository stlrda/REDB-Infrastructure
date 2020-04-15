#-------------------------------------------------------
#Create Airflow Cluster
#-------------------------------------------------------
module "redb-platform" {
  source = "git::https://github.com/stlrda/REDB-Platform"
  cluster_name = var.cluster_name
  tags = var.tags
  aws_region = var.aws_region
  aws_profile = var.aws_profile
  ec2_keypair_name = var.ec2_keypair_name
  public_key_path = var.public_key_path
  private_key_path = var.public_key_path
  admin_email = var.admin_email
  admin_username = var.admin_username
  admin_password = var.admin_password
  fernet_key = var.fernet_key
  time_zone = var.time_zone
  load_examples = var.load_examples
  webserver_instance_type = var.webserver_instance_type
  scheduler_instance_type = var.scheduler_instance_type
  worker_instance_type = var.worker_instance_type
  number_of_workers  = var.number_of_workers
  db_instance_type = var.db_instance_type
  db_dbname = var.db_dbname
  db_username = var.db_username
  db_password = var.db_password
  dag_git_repository_url=var.dag_git_repository_url
  dag_git_repository_directory=var.dag_git_repository_directory
  dag_git_repository_branch=var.dag_git_repository_branch
}

#-------------------------------------------------------------
#Create S3 bucket as ETL processes workspace
#-------------------------------------------------------------
resource "aws_s3_bucket" "airflow_workbucket" {
  bucket = "airflow-workbucket"
  force_destroy = true
  region = var.aws_region
  tags = var.tags
}

#--------------------------------------------------------------
#Create RDS Database as ETL Target
#--------------------------------------------------------------
resource "aws_security_group" "redb_db_security_group" {
  name = "redb_db_security_group"
  description = "Security group for target database"
  vpc_id = module.redb-platform.cluster_vpc_id
  tags = var.tags

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "postgresql-tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_db_instance" "airflow_database" {
  identifier              = "${var.redb_db_name}-db"
  instance_class          = var.redb_db_instance_type
  engine                  = "postgres"
  engine_version          = "11.5"
  name                    = var.redb_db_name
  username                = var.redb_db_username
  password                = var.redb_db_password
  storage_type            = "gp2"
  backup_retention_period = 7
  multi_az                = false
  publicly_accessible     = true
  apply_immediately       = true
  skip_final_snapshot     = true
  vpc_security_group_ids  = ["${aws_security_group.redb_db_security_group.id}"]
  port                    = 5432
  db_subnet_group_name    = module.redb-platform.db_subnet_group
  allocated_storage       = 20
}