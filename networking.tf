resource "aws_vpc" "ESPRITVPC" {
  cidr_block = "10.0.0.0/24" # Defines overall VPC address space
  enable_dns_hostnames = true # Enable DNS hostnames for this VPC
  enable_dns_support = true # Enable DNS resolving support for this VPC
  tags = {
      Name = "VPC-${var.environment}" # Tag VPC with name
  }
}

resource "aws_subnet" "Frontend-prod-sub-az-2a" {
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-2a" # Define AZ for subnet
  cidr_block = "10.0.0.0/27" # Define CIDR-block for subnet
  map_public_ip_on_launch = true # Map public IP to deployed instances in this VPC
  vpc_id = "${aws_vpc.ESPRITVPC.id}" # Link Subnet to VPC
  tags = {
      Name = "Subnet-us-east-2a-prod-Frontend" # Tag subnet with name
  }
}

/*resource "aws_subnet" "Frontend-prod-sub-az-2b" {
  availability_zone = "us-east-2b" # Define AZ for subnet
  cidr_block = "10.0.0.32/27" # Define CIDR-block for subnet
  map_public_ip_on_launch = true # Map public IP to deployed instances in this VPC
  vpc_id = "${aws_vpc.ESPRITVPC.id}" # Link Subnet to VPC
  tags = {
      Name = "Subnet-us-east-2b-prod-Frontend" # Tag subnet with name
  }
}

resource "aws_subnet" "Backend-prod-sub-az-2a" {
    availability_zone = "us-east-2a"
    cidr_block = "10.0.0.64/27"
    map_public_ip_on_launch = true
    vpc_id = "${aws_vpc.ESPRITVPC.id}"
    tags = {
      Name = "Subnet-us-east-2a-prod-Backend"
  }
}

resource "aws_subnet" "Backend-prod-sub-az-2b" {
    availability_zone = "us-east-2b"
    cidr_block = "10.0.0.96/27"
    map_public_ip_on_launch = true
    vpc_id = "${aws_vpc.ESPRITVPC.id}"
    tags = {
      Name = "Subnet-us-east-2b-prod-Backend"
  }
}*/

resource "aws_internet_gateway" "inetgw" {   # To be able to access the instances   
  vpc_id = "${aws_vpc.ESPRITVPC.id}"         #(which have a mapped public IP)
  tags = {                            #from the internet and allows access to the internet
      Name = "IGW-VPC-${var.environment}-Default" #we will need an internet gateway
  }
}

resource "aws_route_table" "TN-default" { #set-up a route-table to attach to the subnets 
  vpc_id = "${aws_vpc.ESPRITVPC.id}"  #which define the default route and allows the subnets 
  route {                             #to talk to each other                  
      cidr_block = "0.0.0.0/0" # Defines default route 
      gateway_id = "${aws_internet_gateway.inetgw.id}" # via IGW
  }

  tags = {
      Name = "Route-Table-TN-Default"
  }
}
resource "aws_route_table_association" "us-east-2a-Frontend-prod" {
  subnet_id = "${aws_subnet.Frontend-prod-sub-az-2a.id}"
  route_table_id = "${aws_route_table.TN-default.id}"
}

/*resource "aws_route_table_association" "us-east-2b-Frontend-prod" {
  subnet_id = "${aws_subnet.Frontend-prod-sub-az-2b.id}"
  route_table_id = "${aws_route_table.TN-default.id}"
}

resource "aws_route_table_association" "us-east-2a-Backend-prod" {
  subnet_id = "${aws_subnet.Backend-prod-sub-az-2a.id}"
  route_table_id = "${aws_route_table.TN-default.id}"
}
resource "aws_route_table_association" "us-east-2b-Backend-prod" {
  subnet_id = "${aws_subnet.Backend-prod-sub-az-2b.id}"
  route_table_id = "${aws_route_table.TN-default.id}"
}*/

