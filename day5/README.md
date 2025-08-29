## Revision 

### terraform 1 

<img src="rev1.png">

### terraform  refresh understanding 

<img src="rev2.png">

## Extending same code 

```
cp -rf day4-code/    day5
```
### verify your day5 

```
[ec2-user@ip-172-31-41-146 ashu-codes]$ cd  day5/
[ec2-user@ip-172-31-41-146 day5]$ 
[ec2-user@ip-172-31-41-146 day5]$ ls
ds.tf  ec2.tf  html-sample-app  main.tf  output.tf  provider.tf  terraform.tfvars  variables.tf
[ec2-user@ip-172-31-41-146 day5]$ ls -a
.  ..  ds.tf  ec2.tf  html-sample-app  main.tf  output.tf  provider.tf  terraform.tfvars  variables.tf
[ec2-user@ip-172-31-41-146 day5]$ tree 

```

## understanding loop in HCL 

<img src="loop.png">

## tip for formatting terraform code 

```
[ec2-user@ip-172-31-41-146 day5]$ terraform fmt 
ds.tf
ec2.tf
output.tf
provider.tf
terraform.tfvars
variables.tf
[ec2-user@ip-172-31-41-146 day5]$ terraform fmt 
ec2.tf
[ec2-user@ip-172-31-41-146 day5]$ 

```

