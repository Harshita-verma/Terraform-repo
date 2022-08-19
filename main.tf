# create VPC

resource "aws_vpc" "Main" {            # Creating VPC here
  cidr_block       = var.main_vpc_cidr # Defining the CIDR block use 10.0.0.0/24 
  instance_tenancy = "default"


  tags = {
    Name = "New-VPC"
  }
}

#Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" { # Creating Internet Gateway
  vpc_id = aws_vpc.Main.id              # vpc_id will be generated after we create VPC

  tags = {
    Name = "Internet-gateway"
  }
}

# Create a Public Subnets.
resource "aws_subnet" "publicsubnets" { # Creating Public Subnets
  vpc_id     = aws_vpc.Main.id
  cidr_block = var.public_subnets # CIDR block of public subnets


  tags = {
    Name = "Public-subnet"
  }

}

#Route table for Public Subnet's
resource "aws_route_table" "PublicRT" { # Creating RT for Public Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Public-Routetable"
  }

}



#Route table for Private Subnet's
resource "aws_route_table" "PrivateRT" { # Creating RT for Private Subnet
  vpc_id = aws_vpc.Main.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.NATgw.id
  }

  tags = {
    Name = "Private-Routetable"
  }

}


# Create a Private Subnet                                        
resource "aws_subnet" "privatesubnets" {
  vpc_id            = aws_vpc.Main.id
  cidr_block        = var.private_subnets
  availability_zone = "eu-west-1a"


  tags = {
    Name                              = "Private-subnet"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }

}



resource "aws_eip" "nateIP" {
  vpc = true

  tags = {
    Name = "Elastic-ip"
  }

}



# Creating the NAT Gateway using subnet_id and allocation_id
resource "aws_nat_gateway" "NATgw" {
  allocation_id = aws_eip.nateIP.id
  subnet_id     = aws_subnet.publicsubnets.id



  tags = {
    Name = "Nat-gateway"
  }
  depends_on = [aws_internet_gateway.IGW]
}

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.privatesubnets.id
  route_table_id = aws_route_table.PrivateRT.id
}


resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.publicsubnets.id
  route_table_id = aws_route_table.PublicRT.id
}


resource "aws_s3_bucket" "bucket" {
  bucket = "harshitav18"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
terraform {
  backend "s3" {
    bucket = "harshitav18"
    key    = "terraform.tfstate"
    region = "eu-west-1"

  }
}



output "console_output" {
  value = aws_subnet.publicsubnets.id
}

output "private_subnet" {
  value = aws_subnet.privatesubnets.id
}

output "vpc_id" {
  value = aws_vpc.Main.enable_dns_hostnames
}


output "vpc-block" {
  value = aws_vpc.Main.cidr_block
}

output "vpc_dns" {
  value = aws_vpc.Main.enable_dns_support
}

output "vpc_hostname" {
  value = aws_vpc.Main.enable_dns_hostnames
}

output "vpc-tags" {
  value = aws_vpc.Main.tags_all
}


output "natgateway_subnet" {
  value = aws_nat_gateway.NATgw.subnet_id
}
output "natgateway_id" {
  value = aws_nat_gateway.NATgw.private_ip
}


output "natgateway_public" {
  value = aws_nat_gateway.NATgw.public_ip
}


