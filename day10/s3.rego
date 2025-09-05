package terraform

deny contains msg if {
  some r
  input.resource_changes[r].type == "aws_s3_bucket"
  not input.resource_changes[r].change.after.server_side_encryption_configuration
  msg := sprintf("Bucket %s must have encryption enabled", [input.resource_changes[r].name])
}
