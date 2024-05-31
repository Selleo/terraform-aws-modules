output "id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "cidr" {
  value       = aws_vpc.this.cidr_block
  description = "The ID of the VPC"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "The ID of the Internet Gateway"
}