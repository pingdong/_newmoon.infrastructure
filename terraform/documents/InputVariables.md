## Variable Definitions Files ##

Terraform also automatically loads a number of variable definitions files if they are present:

* Files named exactly terraform.tfvars or terraform.tfvars.json.
* Any files with names ending in .auto.tfvars or .auto.tfvars.json.

## Environment Variables ##

As a fallback for the other ways of defining variables, Terraform searches the environment of its own process for environment variables named **TF_VAR_** followed by the name of a declared variable.

## Variable Definition Precedence ##

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

* Environment variables
* The terraform.tfvars file, if present.
* The terraform.tfvars.json file, if present.
* Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
* Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)