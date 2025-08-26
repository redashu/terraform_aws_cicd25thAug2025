# terraform_aws_cicd25thAug2025

### Revision

![Revision Screenshot](rev1.png)

## Removing all Terraform internals

```shell
$ ls
ec2.tf  provider.tf  terraform.tfstate  terraform.tfstate.backup

$ ls terraform.tfstate*
terraform.tfstate  terraform.tfstate.backup

$ rm terraform.tfstate*

$ ls
ec2.tf  provider.tf

$ ls -a
.  ..  .terraform  .terraform.lock.hcl  ec2.tf  provider.tf

$ rm -rf .terraform*

$ ls
ec2.tf  provider.tf

$ ls -a
.  ..  ec2.tf  provider.tf
```

### Understanding `terraform init`

```shell
$ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/tls...
- Finding hashicorp/aws versions matching "6.10.0"...
- Finding latest version of hashicorp/local...
- Installing hashicorp/aws v6.10.0...
- Installed hashicorp/aws v6.10.0 (signed by HashiCorp)
- Installing hashicorp/local v2.5.3...
- Installed hashicorp/local v2.5.3 (signed by HashiCorp)
- Installing hashicorp/tls v4.1.0...
- Installed hashicorp/tls v4.1.0 (signed by HashiCorp)

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

$ ls -a
.  ..  .terraform  .terraform.lock.hcl  ec2.tf  provider.tf

$ ls .terraform
providers

$ ls .terraform/providers/
registry.terraform.io

$ ls .terraform/providers/registry.terraform.io/
hashicorp

$ ls .terraform/providers/registry.terraform.io/hashicorp/
aws  local  tls

$ ls .terraform/providers/registry.terraform.io/hashicorp/tls/
4.1.0

$ ls .terraform/providers/registry.terraform.io/hashicorp/tls/4.1.0/
linux_amd64

$ ls .terraform/providers/registry.terraform.io/hashicorp/tls/4.1.0/linux_amd64/
LICENSE.txt  terraform-provider-tls_v4.1.0_x5
```

```shell
$ terraform init --upgrade
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Finding latest version of hashicorp/tls...
- Finding hashicorp/aws versions matching "6.10.0"...
- Using previously-installed hashicorp/aws v6.10.0
- Using previously-installed hashicorp/local v2.5.3
- Using previously-installed hashicorp/tls v4.1.0
```