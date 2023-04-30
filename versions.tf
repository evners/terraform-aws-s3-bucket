# Terraform configuration.
terraform {

  # Required version.
  required_version = "~> 1.4.0"

  # Required providers.
  required_providers {

    # Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

  }

}