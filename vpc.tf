#### VPC ####
resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = false

  tags = {
    Name = "vpc-${var.region_code}"
  }
}

#### internet gateway ####
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.region_code}"
  }
}

#### public_subnet ####
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_list)
  vpc_id = aws_vpc.main.id
  cidr_block =  element(var.public_subnet_cidr_list, count.index)
  availability_zone = format("${var.region[var.region_code]}%s", element(var.azs, count.index))

  tags =  {
    Name = format("public-subnet-%s", element(var.azs, count.index))
  }
}

#### private_subnet ####
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_list)
  cidr_block = element(var.private_subnet_cidr_list, count.index)
  availability_zone = format("${var.region[var.region_code]}%s", element(var.azs, count.index))
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("private-subnet-%s", element(var.azs, count.index))
  }
}

#### Public route_table ####
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  depends_on = [aws_internet_gateway.main]

  tags =  {
    Name = "rt-public"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

#### Private route_table ####
resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_list)
  vpc_id = aws_vpc.main.id
  depends_on = [aws_nat_gateway.private]
  tags = {
    Name = format("rt-private-%s", element(var.azs, count.index))
  }
}
resource "aws_route" "private" {
  count = length(var.private_subnet_cidr_list)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.private.*.id, count.index)
}

#### Nat Gateway ####
resource "aws_nat_gateway" "private" {
  count = length(var.public_subnet_cidr_list)
  allocation_id =element(aws_eip.nat.*.id, count.index)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  tags ={
    Name = format("nat-private-%s", element(var.azs, count.index))
  }
}
#### aws_eip  #####
resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidr_list)
  vpc = true
  tags = {
    Name = format("nat-eip-%s", element(var.azs, count.index))
  }
}
#### Route table association ####
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_list)
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_list)
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}