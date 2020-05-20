variable "target_vpc" {
  default     = ""
  description = "DevMinds Default VPC: aws acct as default"
}

variable "target_subnet" {
  default     = ""
  description = "DevMinds Default VPC SN: eu-west-1a"
}

variable "target_keypairs" {
  default     = ""
  description = "DevMinds default keys: dm-kliuch"
}

variable "project_name" {
  default     = ""
  description = "Name of project"
}

variable "aws_ami" {
  default     = ""
  description = "Currently stuck with centos 7:centos user"
}

variable "server_type" {
  default     = ""
  description = "Medium size servers"
}





