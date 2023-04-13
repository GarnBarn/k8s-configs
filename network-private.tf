resource "aws_subnet" "private-subnet" {
  for_each = data.aws_availability_zone.all

  vpc_id            = aws_vpc.garnbarn-vpc.id
  availability_zone = each.key
  cidr_block        = cidrsubnet(aws_vpc.garnbarn-vpc.cidr_block, 4, var.az_number[each.value.name_suffix])

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_eip" "private-subnet-nat-ip" {
  for_each = aws_subnet.private-subnet

  tags = {
    Name = format("private-subnet-nat-%s-ip", each.key)
  }
}


resource "aws_nat_gateway" "private-nat-gateway" {
  for_each = aws_subnet.private-subnet

  allocation_id = aws_eip.private-subnet-nat-ip[each.key].id
  subnet_id     = aws_subnet.private-subnet[each.key].id

  tags = {
    Name = "private-nat-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw, aws_eip.private-subnet-nat-ip]
}

resource "aws_route_table" "private-routing-table" {
  for_each = aws_subnet.private-subnet

  vpc_id = aws_vpc.garnbarn-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private-nat-gateway[each.key].id
  }

  tags = {
    Name = "private-routing-table"
  }
}
