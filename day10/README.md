# terraform_aws_cicd25thAug2025

### Terraform desire state vs current state 

<img src="rev1.png">

### OPA 

<img src="opa1.png">

## OPA installation in your current platform 

[click_here](https://sangkeon.github.io/opaguide/chap2/installandusage.html)

## OPA demo example 

### POlicy 1 

```
package hello

default message  = "Hello, world"

```

### query the policy with opa CLI

```
opa eval --data  example1.rego  "data.hello.message"
{
  "result": [
    {
      "expressions": [
        {
          "value": "Hello, world",
          "text": "data.hello.message",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}
```

## Demo with terraform understanding OPA 

<img src="opa2.png">


## Demo 

```
terrform init

terraform plan -out=tfplan.binary

 ls
main.tf  tfplan.binary

## convert to json 

terraform show -json tfplan.binary  >tfplan.json 
[ec2-user@ip-172-31-41-146 ec2]$ ls
main.tf  tfplan.binary  tfplan.json
[ec2-user@ip-172-31-41-146 ec2]$ 

```


### using opa to validate the code 

```
 opa eval --data  ec2.rego  --input tfplan.json "data.terraform.deny"
{
  "result": [
    {
      "expressions": [
        {
          "value": {
            "EC2 instance name must not use disallowed type t2.small": true
          },
          "text": "data.terraform.deny",
          "location": {
            "row": 1,
            "col": 1
          }
        }
      ]
    }
  ]
}

```