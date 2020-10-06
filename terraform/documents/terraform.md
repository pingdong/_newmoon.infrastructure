Terraform

terraform init

terraform plan -out <terraform_plan>.tfplan
terraform apply <terraform_plan>.tfplan

terraform plan -destroy -out <terraform_plan>.destroy.tfplan
terraform apply <terraform_plan>.destroy.tfplan