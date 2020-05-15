# Airflow-Infrastructure
A Terraform module for creating an [Apache Airflow](https://airflow.apache.org/) project within the context of the [Airflow-Platorm](https://github.com/stlrda/Airflow-Platform) module and Saint Louis Regional Data Alliance Airflow Project Management Framework (outlined below). 
# Architecture
This module creates numerous AWS resources; the description and diagram provides a general outline, but we encourage organizations to review the module themselves before deploying. This module creates the non-Airflow resources necessary for an Airflow managed ELT program; an S3 bucket for the Airflow workers to store shared workfiles, and a PostGreSQL database to serve as an ELT target.

![Airflow - Infrastructure Architecture Diagram](https://app.lucidchart.com/publicSegments/view/9eeaf448-6905-43d0-9f02-8c3504466b48/image.png)

# Using This Module
In order to use this module, you will first need to install and configure [Terraform](terraform.io) for your machine.

## Backend Setup
Terraform state (the canonical terraform.tfstate file) is stored remotely in S3 so multiple developers can apply using different computers.

An S3 bucket (per region cluster is deployed in) is manually created and referenced in [backend.tf](https://github.com/stlrda/Airflow-Platform/blob/master/backend.tf.example). If your organization is making extensive use of Terraform, a single S3 bucket can be used to store tf states for many projects, as long as their names are unique. At the STLRDA, we use a single bucket (stlrda-terraform-tfstates), and each project has it's own directory and file within the bucket.

In addition to the S3 bucket, a DynamoDB Table must be created manually (per region) and referenced in backend.tf (table name is terraform and the table's Partiton Key must be set as LockID). This table is used to lock states in the event that multiple users attempt to use Terraform simultaneously.

More information on Terraform's S3 backend configuration can be found on [Terraform's website](https://www.terraform.io/docs/backends/types/s3.html).

## TFVARS
The .tfvars file overrides other variables, and serves as the user's way to configure their unique version of their cluster. [terraform.tfvars.example](https://github.com/stlrda/Airflow-Platform/blob/master/terraform.tfvars.example) is included to help the user create their own version. IF YOU ARE FORKING THIS REPO, MAKE SURE TO IGNORE YOUR .tfvars FILE SO YOU DON'T SHARE YOUR AWS CREDENTIALS.

# How STLRDA Manages Airflow Projects
The Saint Louis Regional Data Alliance's Airflow projects are managed using multiple Github repositories. Each repository is linked to and described below; see individual repositories for more information about their place in our ecosystem.

[Airflow-Platorm](https://github.com/stlrda/Airflow-Platform) sets up and configures our Airflow cluster.
         
[Airflow-Admin Tools](https://github.com/stlrda/Airflow-AdminTools) is put into the Airflow/dags folder of each server in the cluster, and provides basic dags that facilitate the administration of the cluster.

[Airflow-Infrastructure](https://github.com/stlrda/Airflow-Infrastructure) is a template repository for creating new Airflow projects. It spins up the non-Airflow AWS resources needed to do data integration work.

[Airflow-Workflows](https://github.com/stlrda/Airflow-Workflows) is a template repository for the DAGs, scripts,and other resources associated with a single Airflow-based ELT project.

## Replicating the STLRDA Workflow
1. Fork [Airflow-Admin Tools](https://github.com/stlrda/Airflow-AdminTools).
2. Modify your version of [clone_and_link.py](https://github.com/stlrda/Airflow-AdminTools/blob/master/scripts/clone_and_link.py) to look at your copy of [projects.csv](https://github.com/stlrda/Airflow-AdminTools/blob/master/resources/projects.csv)   
3. Clone or fork [Airflow-Platorm](https://github.com/stlrda/Airflow-Platform) and follow the provided instructions for setting up your Airflow cluster. Point the github variables in the .tfvars files to your fork of [Airflow-Admin Tools](https://github.com/stlrda/Airflow-AdminTools).
4. For each Airflow project you would like to manage separately, create a separate copy of [Airflow-Infrastructure](https://github.com/stlrda/Airflow-Infrastructure) and run it to spin up an S3 bucket and PostGreSQL database to serve as the ELT target.
5. For each Airflow project you would like to manage separately, create a separate copy of [Airflow-Workflows](https://github.com/stlrda/Airflow-Workflows) to manage the works and scripts associated with the project. Add this repository to your copy of [projects.csv](https://github.com/stlrda/Airflow-AdminTools/blob/master/resources/projects.csv).
6. Run the ImportDags Dag from your Airflow instance to pull in and update all your projects.