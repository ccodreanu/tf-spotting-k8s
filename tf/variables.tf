variable "profile" {
  description = "Profile from AWS CLI to be used"
  default = "default"
}


variable "aws_region" {
  description = "AWS region to be used"
  default = "eu-central-1"
}

variable "key" {
  description = "Name of the SSH key"
  default = "main_ssh_key"
}

variable "public_key" {
  description = "SSH public key path"
  default = "~/.ssh/id_rsa.pub"
}


variable "aws_amis" {
  description = "AMIs per region"
  default = {
    "eu-central-1" = "ami-00aa4671cbf840d82"
  }
}
