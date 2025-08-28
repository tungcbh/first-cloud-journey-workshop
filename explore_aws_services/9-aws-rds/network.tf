variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {
  state = "available"
}

#vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = "Lab VPC"
    Environment = "Development"
  }
}

#internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Lab IGW"
  }
}

#public subnet
resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Lab Public Subnet ${count.index + 1}"
  }
}

#private subnet
resource "aws_subnet" "private" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 2)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "Lab Private Subnet ${count.index + 1}"
  }
}

# eip
# resource "aws_eip" "nat" {
#   count = 2

#   domain     = "vpc"
#   depends_on = [aws_internet_gateway.main]

#   tags = {
#     Name = "NAT gateway EIP ${count.index + 1}"
#   }
# }

# #NAT gateway
# resource "aws_nat_gateway" "main" {
#   count = 2

#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id

#   tags = {
#     Name = "Lab NAT Gateway ${count.index + 1}"
#   }

#   depends_on = [aws_internet_gateway.main]
# }

#public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Lab Public Route Table"
  }
}

#private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  count  = 2

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
    # nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "Lab Private Route Table"
  }
}

#route table association public
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#route table association private
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
