terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.66.0" # which means any version equal & above
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  #shared_credentials_files = "C:\Users\Shiva\Desktop\aws-creds"
  #profile = "default"
  access_key = "AxxxxxxxxxxxZ"
  secret_key = "wCxxxxxxxxxxxxxxxxxxxxxgT"
}
