resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.garnbarn-vpc.id
  availability_zone = keys(data.aws_availability_zone.all)[0]
  cidr_block        = cidrsubnet(aws_vpc.garnbarn-vpc.cidr_block, 4, var.az_number["f"])

  tags = {
    Name = "public-subnet"
  }
}
