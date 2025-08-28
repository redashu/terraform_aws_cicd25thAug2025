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

### more commands 

```
ec2-user@ip-172-31-41-146 day4-code]$ terraform apply --auto-approve 
data.aws_vpc.my-vpc: Reading...
data.aws_vpc.my-vpc: Read complete after 2s [id=vpc-0fc2423d09f6affec]
aws_security_group.allow_tls: Refreshing state... [id=sg-0e217e0e4d63585be]
aws_vpc_security_group_egress_rule.example-all-ipv4: Refreshing state... [id=sgr-002a33e3ab4660b6c]
aws_vpc_security_group_ingress_rule.example-ssh: Refreshing state... [id=sgr-0f1372e223557810b]
aws_vpc_security_group_egress_rule.example-allipv6: Refreshing state... [id=sgr-0271dab9b90022b5a]
aws_vpc_security_group_ingress_rule.example-http: Refreshing state... [id=sgr-06a7b305bde1740c2]

Changes to Outputs:
  + my-securitygroup = "my security group name is allow_tls"
  + my-vpc-id        = "vpc-0fc2423d09f6affec"

You can apply this plan to save these new output values to the Terraform state, without changing any real
infrastructure.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

my-securitygroup = "my security group name is allow_tls"
my-vpc-id = "vpc-0fc2423d09f6affec"
[ec2-user@ip-172-31-41-146 day4-code]$ terraform output 
my-securitygroup = "my security group name is allow_tls"
my-vpc-id = "vpc-0fc2423d09f6affec"
[ec2-user@ip-172-31-41-146 day4-code]$ 

```