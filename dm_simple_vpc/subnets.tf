#
# PublicNetwork(Subnet) ===> Router ===> IGW ===> Internet
# Public ip address gets automatically associated with resources 
#

resource "aws_subnet" "dm_pub_res" {
  count                   = length(var.pub_ip_range)
  vpc_id                  = aws_vpc.dm_vpc_res.id
  cidr_block              = var.pub_ip_range[count.index]
  availability_zone       = var.pub_azs[count.index]
  map_public_ip_on_launch = true
  tags = merge({
    "Name" = format("%s-pub-%d", var.name_tag, count.index)
  })
}

resource "aws_route_table" "dm_pub_rtt_res" {
  vpc_id = aws_vpc.dm_vpc_res.id
  tags = merge({
    "Name" = format("%s-pub", var.name_tag)
  })
}

resource "aws_route" "dm_pub_rt_res" {
  route_table_id         = aws_route_table.dm_pub_rtt_res.id
  gateway_id             = aws_internet_gateway.dm_gtw_res.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "dm_pub_rt_assoc" {
  count          = length(var.pub_ip_range)
  subnet_id      = aws_subnet.dm_pub_res.*.id[count.index]
  route_table_id = aws_route_table.dm_pub_rtt_res.id
}

resource "aws_network_acl" "dm_pub_nacl_res" {
  vpc_id     = aws_vpc.dm_vpc_res.id
  subnet_ids = aws_subnet.dm_pub_res.*.id
  tags = merge({
    "Name" = format("%s-pub", var.name_tag)
  })
}

resource "aws_network_acl_rule" "dm_pub_nacl_ing_res" {
  network_acl_id = aws_network_acl.dm_pub_nacl_res.id
  egress         = false
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "dm_pub_nacl_egr_res" {
  network_acl_id = aws_network_acl.dm_pub_nacl_res.id
  egress         = true
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

#
# PrivateNetwork(Subnet) ===> Router ? NATG ? 1 : 0
# Private ip only on resource anpossibly points to NAT if enable
#

resource "aws_subnet" "dm_priv_res" {
  count                   = length(var.priv_ip_range)
  vpc_id                  = aws_vpc.dm_vpc_res.id
  cidr_block              = var.priv_ip_range[count.index]
  availability_zone       = var.priv_azs[count.index]
  map_public_ip_on_launch = false
  tags = merge({
    "Name" = format("%s-priv-%d", var.name_tag, count.index)
  })
}

resource "aws_route_table" "dm_priv_rtt_res" {
  count  = length(var.priv_ip_range)
  vpc_id = aws_vpc.dm_vpc_res.id
  tags = merge({
    "Name" = format("%s-priv", var.name_tag)
  })
}

resource "aws_route" "dm_priv_rt_res" {
  count                  = var.enabled_nat_gateway ? length(var.priv_ip_range) : 0
  route_table_id         = aws_route_table.dm_priv_rtt_res.*.id[count.index]
  nat_gateway_id         = var.enabled_single_nat_gateway ? aws_nat_gateway.dm_natg_res.*.id[0] : aws_nat_gateway.dm_natg_res.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "dm_priv_rt_assoc" {
  count          = length(var.priv_ip_range)
  subnet_id      = aws_subnet.dm_pub_res.*.id[count.index]
  route_table_id = aws_route_table.dm_pub_rtt_res.id
}

resource "aws_network_acl" "dm_priv_nacl_res" {
  vpc_id     = aws_vpc.dm_vpc_res.id
  subnet_ids = aws_subnet.dm_priv_res.*.id
  tags = merge({
    "Name" = format("%s-priv", var.name_tag)
  })
}

resource "aws_network_acl_rule" "dm_ppriv_nacl_ing_res" {
  network_acl_id = aws_network_acl.dm_priv_nacl_res.id
  egress         = false
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "dm_priv_nacl_egr_res" {
  network_acl_id = aws_network_acl.dm_priv_nacl_res.id
  egress         = true
  from_port      = 0
  to_port        = 0
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
}