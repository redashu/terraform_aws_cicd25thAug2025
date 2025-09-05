package terraform

# Disallowed instance types
disallowed_types := {"t2.small", "t2.medium", "t3.micro"}

deny[msg] if {
  some r
  input.resource_changes[r].type == "aws_instance"
  itype := input.resource_changes[r].change.after.instance_type
  itype in disallowed_types
  name := input.resource_changes[r].name
  msg := sprintf("EC2 instance %s must not use disallowed type %s", [name, itype])
}
