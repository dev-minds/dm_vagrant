# All variables 
variable "ip_range" {
  description = "Specify cidr block for your VPC"
  type        = string
  default     = ""
}

variable "inst_tenancy" {
  description = "Specify ec2 instances tenancy"
  type        = string
  default     = "default"
}

variable "name_tag" {
  description = "Specify Name tag fot vpc"
  type        = string
  default     = ""
}

variable "dns_support" {
  description = "Specify to enable dns-support"
  type        = string
  default     = "false"
}

variable "dns_hostn" {
  description = "Specify to enable dns_hostn"
  type        = string
  default     = "false"
}

variable "pub_ip_range" {
  description = "Specify public ip ranges"
  type        = list
  default     = []
}

variable "pub_azs" {
  description = "Specify which public availability zones"
  type        = list
  default     = []
}

variable "priv_ip_range" {
  description = "Specify private ip ranges"
  type        = list
  default     = []
}

variable "priv_azs" {
  description = "Specify which private availability zones"
  type        = list
  default     = []
}

variable "enabled_nat_gateway" {
  description = "Tip just set to false and save money"
  default     = "false"
  type        = string
}

variable "enabled_single_nat_gateway" {
  description = "Just set to false"
  default     = ""
  type        = string
}
