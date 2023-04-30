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

    # The "random" provider allows the use of randomness within Terraform configurations. This is a logical provider,
    # which means that it works entirely within Terraform's logic, and doesn't interact with any other services.
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

  }

}
