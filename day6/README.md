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

