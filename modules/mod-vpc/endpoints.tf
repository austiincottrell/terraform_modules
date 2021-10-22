resource aws_vpc_endpoint "myend" {
  count              = length(var.endpoint)
  vpc_id             = aws_vpc.vpc.id

  vpc_endpoint_type  = lookup(var.endpoint[count.index], "type")
  service_name       = lookup(var.endpoint[count.index], "service_name")
  security_group_ids = [aws_security_group.myend.id]
  
  policy = <<EOF
{
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
  EOF
  tags = {
    Name = "rds-data-api"
  }
}

resource "aws_security_group" "myend"{
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = [var.cidr_block]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.cidr_block]
  }

  tags = {
      Name = "my-endpoint-sg"
  }
}