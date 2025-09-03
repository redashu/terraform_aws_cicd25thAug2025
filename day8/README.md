# terraform_aws_cicd25thAug2025
## quick revision about Github actions cicd 

<img src="rev1.png">

### infra provisoning vs configuration management 

<img src="tool1.png">

## basic info about Ansible 

<img src="ans1.png">

### ansible components 

<img src="ans2.png">

### doing the directory setup 

```
ec2-user@ip-172-31-41-146 ashu-codes]$ mkdir ansible-day8
[ec2-user@ip-172-31-41-146 ashu-codes]$ 
[ec2-user@ip-172-31-41-146 ashu-codes]$ ansible --version 
ansible [core 2.15.3]
  config file = None
  configured module search path = ['/home/ec2-user/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.9/site-packages/ansible
  ansible collection location = /home/ec2-user/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.9.23 (main, Aug 11 2025, 00:00:00) [GCC 11.5.0 20240719 (Red Hat 11.5.0-5)] (/usr/bin/python3.9)
  jinja version = 3.1.4
  libyaml = True
[ec2-user@ip-172-31-41-146 ashu-codes]$ touch ansible-day8/inventory 
[ec2-user@ip-172-31-41-146 ashu-codes]$ touch ansible-day8/ansible.cfg 
[ec2-user@ip-172-31-41-146 ashu-codes]$ touch ansible-day8/webapp-playbook.yaml 
[ec2-user@ip-172-31-41-146 ashu-codes]$ tree ansible-day8/
ansible-day8/
├── ansible.cfg
├── inventory
└── webapp-playbook.yaml

0 directories, 3 files
[ec2-user@ip-172-31-41-146 ashu-codes]$ 

```