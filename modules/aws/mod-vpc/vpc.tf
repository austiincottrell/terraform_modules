locals {
  number_subs  = length(var.subnet_name)
  public_subs  = length(var.public_subs)
  private_subs = length(var.private_subs)

  az  = data.aws_availability_zones.available.names
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

  availability_zone = element(local.az, count.index)
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

resource "aws_route_table_association" "public" {
  count          = local.public_subs
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.public_route.id
}

#====================================================

resource "aws_eip" "nat_gw_eip" {
  count = var.nat_gateway == false ? 0 : 1
  vpc   = true
}

resource "aws_nat_gateway" "nat_gw" {
  count         = var.nat_gateway == false ? 0 : 1
  allocation_id = aws_eip.nat_gw_eip[0].id
  subnet_id     = aws_subnet.subnet[1].id

  depends_on = [aws_internet_gateway.internet_gateway]
}

#====================================================


resource "aws_route_table" "private_route" {
  count  = var.nat_gateway == false ? 0 : 1
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[0].id
  }

  tags = {
    Name = "Private Routes"
  }
}

resource "aws_route_table_association" "private" {
  count          = var.nat_gateway == false ? 0 : local.private_subs
  subnet_id      = aws_subnet.subnet[count.index + 2].id
  route_table_id = aws_route_table.private_route[0].id
}