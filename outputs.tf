# Network outputs
output "vpc_id" {
  value = aws_vpc.main.*.id
}
output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}
output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}
output "private_route_table" {
  value = aws_route_table.private.*.id
}
output "azs" {
  value = var.azs
}
output "dns_name" {
  value       = aws_lb.alb.dns_name
}