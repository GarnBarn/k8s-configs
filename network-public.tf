resource "aws_subnet" "public-subnet" {
  for_each = data.aws_availability_zone.all


  vpc_id     = aws_vpc.garnbarn-vpc.id
  cidr_block = cidrsubnet(aws_vpc.garnbarn-vpc.cidr_block, 4, var.az_number[each.value.name_suffix])

  tags = {
    Name = "public-subnet"
  }
}
