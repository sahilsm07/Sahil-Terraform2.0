resource "aws_vpc" "prod-vpc" {
  cidr_block       = var.vpc-cidr

  tags = {
    Name = "Sahil Vpc"
    Owner = "Sahil Mehta"
    purpose = "Sprint2"
  }
}

resource "aws_subnet" "prod-private-subnets" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.azs)
  cidr_block = element(var.prod-private-subnets , count.index)
  availability_zone = element(var.azs , count.index)

  tags = {
    Name = "Sahil Production Private Subnet"
    Owner = "Sahil Mehta"
    purpose = "Sprint2"
  }
}

resource "aws_subnet" "prod-public-subnets" {
  vpc_id = aws_vpc.prod-vpc.id
  count = length(var.azs)
  cidr_block = element(var.prod-public-subnets , count.index)
  availability_zone = element(var.azs , count.index)

  tags = {
    Name = "Sahil Production Public Subnet"
    Owner = "Sahil Mehta"
    purpose = "Sprint2"
  }
}

#IGW
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "Sahil Internet gateway"
    Owner = "Sahil Mehta"
    purpose = "Sprint2"
  }
}

#route table for public subnet
resource "aws_route_table" "prod-public-rtable" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "Sahil Route Table"
    Owner = "Sahil Mehta"
    purpose = "Sprint2"
  }
}

# #route table association public subnets using count
# resource "aws_route_table_association" "public-subnet-association" {
#   count          = length(var.prod-public-subnets)
#   subnet_id      = element(aws_subnet.prod-public-subnets.*.id , count.index)
#   route_table_id = aws_route_table.prod-public-rtable.id
# }


#add routes to public-rtable this is just for testing of for_each loop
resource "aws_route" "ner-subnets-public-rtable" {
  route_table_id            = aws_route_table.prod-public-rtable.id
  gateway_id                = aws_internet_gateway.prod-igw.id
  for_each                  = toset(var.public-subnets)
  destination_cidr_block = each.value
}

#backend
resource "aws_s3_bucket" "aws_s3_bucketInstance"{
    for_each=var.aws_s3_tag
    bucket=each.value["name"]
    tags={
        Name=each.value["name"]
        Owner=each.value["owner"]
        Purpose=each.value["purpose"]
    }
}