variable "region_number" {
  # Arbitrary mapping of region name to number to use in
  # a VPC's CIDR prefix.
  default = {
    us-east-1 = 1
    us-east-2 = 2
  }
}

variable "az_number" {
  # Assign a number to each AZ letter used in our configuration
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
    # and so on, up to n = 14 if that many letters are assigned
  }
}

data "aws_region" "current" {}

# Determine all of the available availability zones in the
# current AWS region.
data "aws_availability_zones" "available" {
  state = "available"
}

# This additional data source determines some additional
# details about each VPC, including its suffix letter.
data "aws_availability_zone" "all" {
  for_each = toset([for i in range(var.limit_zone_number) : data.aws_availability_zones.available.names[i]])

  name = each.key
}

variable "limit_zone_number" {
  description = "The number of zone per region"
  default     = 2
}

