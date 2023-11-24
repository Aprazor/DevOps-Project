resource "aws_vpc" "terraform_vpc" {
    cidr_block = "10.1.0.0/16"
    # enable_dns_hostnames = true
    # enable_dns_support = true
    tags = {
        Name = "terraform_vpc"
    }
}

resource "aws_subnet" "terraform_subnet-01" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-1a"
    tags = {
        Name = "terraform_subnet-01"
    }
}

resource "aws_subnet" "terraform_subnet-02" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = "10.1.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-1c"
    tags = {
        Name = "terraform_subnet-02"
    }
}

resource "aws_internet_gateway" "terraform_igw" {
    vpc_id = aws_vpc.terraform_vpc.id
    tags = {
        Name = "terraform_igw"
    }
}

resource "aws_route_table" "terraform_route_table" {
    vpc_id = aws_vpc.terraform_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform_igw.id
    }
    tags = {
        Name = "terraform_route_table"
    }
}

resource "aws_route_table_association" "terraform-rta-public-subnet-01" {
  subnet_id = aws_subnet.terraform_subnet-01.id
  route_table_id = aws_route_table.terraform_route_table.id  
}

resource "aws_route_table_association" "dpp-rta-public-subnet-02" {
  subnet_id = aws_subnet.terraform_subnet-02.id
  route_table_id = aws_route_table.terraform_route_table.id     
}
# resource "aws_main_route_table_association" "terraform_rtbassoc" {
#     vpc_id = aws_vpc.terraform_vpc.id
#     route_table_id = aws_route_table.terraform_route_table.id
# }
