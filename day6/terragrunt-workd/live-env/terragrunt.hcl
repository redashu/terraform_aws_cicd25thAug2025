remote_state {
    backend = "s3"
    config = {
        bucket = ""
        key = ""
        region = ""
        dynamodb_table = ""
        encrypt = true 
    }
}