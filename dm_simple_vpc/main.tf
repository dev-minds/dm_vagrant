# Tf for vpc spinup
# Controls NAT Gateway provisioning 

resource "aws_vpc" "dm_vpc_res" {
  cidr_block           = var.ip_range
  instance_tenancy     = var.inst_tenancy
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostn

  tags = merge({
    "Name" = var.name_tag
  })
}

resource "aws_internet_gateway" "dm_gtw_res" {
  vpc_id = aws_vpc.dm_vpc_res.id
  tags = merge({
    "Name" = var.name_tag
  })
}

