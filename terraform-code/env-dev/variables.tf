variable "environment" {
    description = "The AWS environment"
}

variable "aws_region" {
    description = "The AWS region"
    default = "us-east-1"
}

variable "tag_owner" {
    description = "Tag Owner value"
    default = "devops-tecbeats-poc"  
}