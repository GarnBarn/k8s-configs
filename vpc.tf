resource "aws_vpc" "garnbarn-vpc" {
  cidr_block       = cidrsubnet("10.0.0.0/8", 8, var.region_number[data.aws_region.current.name])
  instance_tenancy = "default"

  tags = {
    Name = "garnbarn-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.garnbarn-vpc.id

  tags = {
    Name = "garnbarn-igw"
  }
}
