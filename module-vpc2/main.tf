
	
#------------------------------------------------------------
   ########bloque Despliegue ########

	### para vpc
resource "aws_vpc" "myVpc"{
	cidr_block="${var.cidr_block_vpc}"
	instance_tenancy="${var.instance_tenancy}"
	assign_generated_ipv6_cidr_block ="${var.assign_generated_ipv6_cidr_block}"
	tags{
		Name="${var.name-vpc}"
	}
}

#----------------------------
	### para subnet
resource "aws_subnet" "subnetPublic1" {
  vpc_id            = "${aws_vpc.myVpc.id}"
  availability_zone = "${var.availability_zone}"
  cidr_block        = "${var.cidr_block_subnet1}"
  tags {
        Name = "${var.name-public-subnet1}"
  }
}

resource "aws_subnet" "subnetPublic2" {
  vpc_id            = "${aws_vpc.myVpc.id}"
  availability_zone = "${var.availability_zone}"
  cidr_block        = "${var.cidr_block_subnet2}"
  tags {
        Name = "${var.name-public-subnet2}"
  }
}

resource "aws_subnet" "subnetPublic3" {
  vpc_id            = "${aws_vpc.myVpc.id}"
  availability_zone = "${var.availability_zone}"
  cidr_block        = "${var.cidr_block_subnet3}"
  tags {
        Name = "${var.name-public-subnet3}"
  }
}

resource "aws_subnet" "subnetPrivate1" {
  vpc_id            = "${aws_vpc.myVpc.id}"
  availability_zone = "${var.availability_zone}"
  cidr_block        = "${var.cidr_block_subnet4}"
  tags {
        Name = "${var.name-private-subnet1}"
  }
}

resource "aws_subnet" "subnetPrivate2" {
  vpc_id            = "${aws_vpc.myVpc.id}"
  availability_zone = "${var.availability_zone}"
  cidr_block        = "${var.cidr_block_subnet5}"
  tags {
        Name = "${var.name-private-subnet2}"

  }
}

resource "aws_subnet" "subnetPrivate3" {
  vpc_id            = "${aws_vpc.myVpc.id}"
  availability_zone = "${var.availability_zone}"
  cidr_block        = "${var.cidr_block_subnet6}"
  tags {
        Name = "${var.name-private-subnet3}"
  }
}
#----------------------------
	###para internet gateway
resource "aws_internet_gateway" "igw"{
	  vpc_id            = "${aws_vpc.myVpc.id}"
	  tags{
		Name="${var.name-gatway}"
	  }
}

#----------------------------
	###para elastic ip 
resource "aws_eip" "eip"{
	vpc=true
	
}

#----------------------------
	###para nat gateway
resource "aws_nat_gateway" "ngw"{
	  allocation_id ="${aws_eip.eip.id}"
	  #alojado en subnet publica 1 
	  subnet_id     ="${aws_subnet.subnetPublic1.id}"
}

#----------------------
	###para route_table
resource "aws_route_table" "routeTablePublic"{
  vpc_id            = "${aws_vpc.myVpc.id}"
  route {
        cidr_block = "${var.cidr_block_gateway}"
        gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.name-table-public}"
  }
}

resource "aws_route_table" "routeTablePrivate"{
  vpc_id            = "${aws_vpc.myVpc.id}"
  route {
        cidr_block = "${var.cidr_block_gateway}"
        nat_gateway_id= "${aws_nat_gateway.ngw.id}"
  }
  tags {
    Name = "${var.name-table-private}"
  }
}


#-----------------------
	#para asociacion entre subnet y routing table
resource "aws_route_table_association" "a1" {
  subnet_id      = "${aws_subnet.subnetPublic1.id}"
  route_table_id = "${aws_route_table.routeTablePublic.id}"
}

resource "aws_route_table_association" "a2" {
  subnet_id      = "${aws_subnet.subnetPublic2.id}"
  route_table_id = "${aws_route_table.routeTablePublic.id}"
}

resource "aws_route_table_association" "a3" {
  subnet_id      = "${aws_subnet.subnetPublic3.id}"
  route_table_id = "${aws_route_table.routeTablePublic.id}"
}

resource "aws_route_table_association" "a4" {
  subnet_id      = "${aws_subnet.subnetPrivate1.id}"
  route_table_id = "${aws_route_table.routeTablePrivate.id}"
}

resource "aws_route_table_association" "a5" {
  subnet_id      = "${aws_subnet.subnetPrivate2.id}"
  route_table_id = "${aws_route_table.routeTablePrivate.id}"
}

resource "aws_route_table_association" "a6" {
  subnet_id      = "${aws_subnet.subnetPrivate3.id}"
  route_table_id = "${aws_route_table.routeTablePrivate.id}"
}




