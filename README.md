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
terraform init
terraform apply
Testing
Wait for the load balancer to be provisioned:
./test.sh
Verify response from load balancer:
curl http://$(terraform output load-balancer-ip)
Connecting with kubectl
Get the cluster credentials and configure kubectl:
gcloud container clusters get-credentials $(terraform output cluster_name) --zone $(terraform output cluster_zone)
Verify kubectl connectivity:
kubectl get pods -n staging
Cleanup
Delete resources created by terraform:
terraform destroy
