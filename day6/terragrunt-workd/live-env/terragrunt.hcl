remote_state {
    backend = "s3"
    config = {
        bucket = "ashutoshh-terragruntbkt"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "us-east-2"
        dynamodb_table = "ashu-terrgrunt-table"
        encrypt = true 
    }
}