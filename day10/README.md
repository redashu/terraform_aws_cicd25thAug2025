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