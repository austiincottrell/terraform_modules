resource "aws_network_acl" "secure_private_subnet" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.subnet[2].id, aws_subnet.subnet[3].id]
  
  dynamic "ingress" {
    for_each = var.private_acl
    content {
      from_port  = ingress.value["port"]
      to_port    = ingress.value["port2"]
      protocol   = ingress.value["type"]
      action     = "allow"
      cidr_block = ingress.value["cidr"]
      rule_no    = ingress.value["rule"]
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Private Subnets acl"
  }
}

resource "aws_network_acl" "secure_db_subnet" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.subnet[4].id, aws_subnet.subnet[5].id, aws_subnet.subnet[6].id]
  
  dynamic "ingress" {
    for_each = var.db_acl
    content {
      from_port  = ingress.value["port"]
      to_port    = ingress.value["port2"]
      protocol   = ingress.value["type"]
      action     = "allow"
      cidr_block = ingress.value["cidr"]
      rule_no    = ingress.value["rule"]
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "db acl"
  }
}