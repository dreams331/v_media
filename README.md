# v_media

Install Terraform
Install Terraform if it is not already installed (visit terraform.io for other distributions):
../terraform-install.sh

Set up the environment
Set the project, replace YOUR_PROJECT with your project ID:
PROJECT=YOUR_PROJECT
gcloud config set project ${PROJECT}


Configure the environment for Terraform:
[[ $CLOUD_SHELL ]] || gcloud auth application-default login
export GOOGLE_PROJECT=$(gcloud config get-value project)


Run Terraform
terraform init: 
To initialize a working directory containing Terraform configuration files.

terraform Plan: 
To evaluates the Terraform configuration to determine the desired state of all the resources that it declares, then compares that desired state to the real infrastructure objects being managed with the current working directory and workspace.

terraform apply: 
To performs a plan just like terraform plan does, but then actually carries out the planned changes/create to each resource using the relevant infrastructure provider's API


terraform destroy:
To delete resources created by terraform:
