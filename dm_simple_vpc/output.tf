output "vpc_id_otp" {
  description = "Fetch VPC ID "
  value       = concat(aws_vpc.dm_vpc_res.*.id, [""])[0]
}
