locals {
  number_subs  = length(var.subnet_name)
  public_subs  = length(var.public_subs)
  private_subs = length(var.private_subs)

  total_az = concat(local.az, local.az2, local.az3, local.az4)
  az  = data.aws_availability_zones.available.names
  az2 = data.aws_availability_zones.available.names
  az3 = data.aws_availability_zones.available.names
  az4 = data.aws_availability_zones.available.names
}

resource "aws_vpc" "vpc" {
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames
  cidr_block           = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnet" {
  count                   = local.number_subs
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = lookup(var.public_subnets, count.index)

  availability_zone = element(local.total_az, count.index)
  cidr_block        = cidrsubnet(var.subnet_cidr, 8, count.index)

  tags = {
    name = lookup(var.subnet_name, count.index)
    Name = lookup(var.subnet_name, count.index)
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

#====================================================

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Routes"
  }
}

resource "aws_route_table_association" "subnet0" {
  count          = local.public_subs
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
}

#====================================================

resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.subnet[1].id

  depends_on = [aws_internet_gateway.internet_gateway]
}

#====================================================


resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private Routes"
  }
}

resource "aws_route_table_association" "private" {
  count          = local.private_subs
  subnet_id      = aws_subnet.subnet[count.index + 2].id
  route_table_id = aws_route_table.private_route.id
}