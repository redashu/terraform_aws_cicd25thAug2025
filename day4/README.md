# terraform_aws_cicd25thAug2025

### directory struecture for today

```
 mkdir  day4-code
[ec2-user@ip-172-31-41-146 ashu-codes]$ touch day4-code/{provider.tf,main.tf,variables.tf,output.tf,ds.tf}
[ec2-user@ip-172-31-41-146 ashu-codes]$ tree day4-code/
day4-code/
├── ds.tf
├── main.tf
├── output.tf
├── provider.tf
└── variables.tf

0 directories, 5 files
[ec2-user@ip-172-31-41-146 ashu-codes]$  touch day4-code/terraform.tfvars
[ec2-user@ip-172-31-41-146 ashu-codes]$ tree day4-code/
day4-code/
├── ds.tf
├── main.tf
├── output.tf
├── provider.tf
├── terraform.tfvars
└── variables.tf

```

### reading existing resoruce

```
ec2-user@ip-172-31-41-146 day4-code]$ terraform  init 
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "6.10.0"...
- Installing hashicorp/aws v6.10.0...
- Installed hashicorp/aws v6.10.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
[ec2-user@ip-172-31-41-146 day4-code]$ terraform plan
data.aws_vpc.my-vpc: Reading...
data.aws_vpc.my-vpc: Read complete after 1s [id=vpc-0fc2423d09f6affec]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
[ec2-user@ip-172-31-41-146 day4-code]$ terraform apply --auto-approve
data.aws_vpc.my-vpc: Reading...
data.aws_vpc.my-vpc: Read complete after 2s [id=vpc-0fc2423d09f6affec]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[ec2-user@ip-172-31-41-146 day4-code]$ 
[ec2-user@ip-172-31-41-146 day4-code]$ 
[ec2-user@ip-172-31-41-146 day4-code]$ terraform state list
data.aws_vpc.my-vpc

```