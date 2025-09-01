## Getting started with Revision 

## Revision 1 

<img src="rev1.png">

## Revision 2


<img src="rev2.png">

## Dealing with Modules in terraform 

### Creating directory structure for modules 

```
[ec2-user@ip-172-31-41-146 ashu-codes]$ mkdir day6
[ec2-user@ip-172-31-41-146 ashu-codes]$ mkdir day6/modules
[ec2-user@ip-172-31-41-146 ashu-codes]$ mkdir day6/modules/vpc
[ec2-user@ip-172-31-41-146 ashu-codes]$ mkdir day6/modules/s3
[ec2-user@ip-172-31-41-146 ashu-codes]$ tree  day6/
day6/
└── modules
    ├── s3
    └── vpc

3 directories, 0 files

```
### final directory structure 

```
 tree  day6/
day6/
├── modules
│   ├── s3
│   └── vpc
└── use_modules
    └── ec2

```

### Terraform modules type 

<img src="md1.png">

### problem with terraform in case of huge projects or Multi env cases

<img src="md2.png">

## basic intro about Terragrunt

<img src="tg1.png">

## some advantages of terrgrunt 

<img src="tg2.png">

### checking terragrunt version 

```
ec2-user@ip-172-31-41-146 use_modules]$ terragrunt  run --version 
terragrunt version v0.86.1
[ec2-user@ip-172-31-41-146 use_modules]$ 

```

## lets start implementing multi environment  directory structure 

```
mkdir  terragrunt-work
[ec2-user@ip-172-31-41-146 day6]$ cd terragrunt-work/
[ec2-user@ip-172-31-41-146 terragrunt-work]$ ls
[ec2-user@ip-172-31-41-146 terragrunt-work]$ 
[ec2-user@ip-172-31-41-146 terragrunt-work]$ 
[ec2-user@ip-172-31-41-146 terragrunt-work]$ mkdir  infra-modules  infra-live 
[ec2-user@ip-172-31-41-146 terragrunt-work]$ tree .
.
├── infra-live
└── infra-modules

2 directories, 0 files
[ec2-user@ip-172-31-41-146 terragrunt-work]$ mkdir  infra-modules/{ec2,vpc}
[ec2-user@ip-172-31-41-146 terragrunt-work]$ tree .
.
├── infra-live
└── infra-modules
    ├── ec2
    └── vpc

4 directories, 0 files
[ec2-user@ip-172-31-41-146 terragrunt-work]$ mkdir  infra-live/{dev,stage,prod}
[ec2-user@ip-172-31-41-146 terragrunt-work]$ tree .
.
├── infra-live
│   ├── dev
│   ├── prod
│   └── stage
└── infra-modules
    ├── ec2
    └── vpc
```