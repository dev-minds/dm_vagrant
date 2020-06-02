# ================================================= #
locals {
  nat_gateway_count = var.enabled_nat_gateway ? var.enabled_single_nat_gateway ? 1 : length(var.priv_ip_range) : 0
}


resource "aws_eip" "dm_eip_res" {
  count = local.nat_gateway_count
  vpc   = true
  tags = merge({
    "Name" = format("%s-eip-%d", var.name_tag, count.index)
  })
  depends_on = [aws_internet_gateway.dm_gtw_res]
}

resource "aws_nat_gateway" "dm_natg_res" {
  count         = local.nat_gateway_count
  allocation_id = aws_eip.dm_eip_res.*.id[count.index]
  subnet_id     = aws_subnet.dm_pub_res.*.id[count.index]
  tags = merge({
    "Name" = format("%s-natg-%d", var.name_tag, count.index)
  })
  depends_on = [aws_internet_gateway.dm_gtw_res]
}
