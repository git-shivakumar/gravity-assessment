##### VPC #######

resource "aws_vpc" "gravity-vpc" {
 cidr_block = "10.0.0.0/16"
 enable_dns_support = true
 enable_dns_hostnames = true
 
 tags = {
   Name = "gravity-demo-vpc"
 }
}


######## Subnets ##########

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.gravity-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "gravity-private-subnet"
  }
}


resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.gravity-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "gravity-public-subnet"
  }
}


####### IGW #########
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.gravity-vpc.id
  tags = {
    Name = "gravity-vpc-IGW"
    }
}

###### NAT GW #######
resource "aws_eip" "nat-eip" {
  vpc = true
   tags = {
      Name = "gravity-vpc-nat-eip"
      }
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
      Name = "gravity-vpc-nat-gw"
      }
}


###### Public route table ##########
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.gravity-vpc.id
  tags = {
    Name = "gravity-public-route-table"
  }
}

####### Public route table associations #########
resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
}


####### Private route table ##########
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.gravity-vpc.id
  tags = {
    Name = "gravity-private-route-table"
  }
}

####### Private route table associations #########
resource "aws_route" "private-route" {
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat-gateway.id
}

resource "aws_route_table_association" "private-subnet-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-route-table.id
}
