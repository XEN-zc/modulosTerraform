output "vpc" {
  value ="${aws_vpc}"
}

output "subnet-public1" {
  value ="${aws_subnet.subnetPublic1.id}"
}

output "subnet-public2" {
  value ="${aws_subnet.subnetPublic2.id}"
}

output "subnet-public3" {
  value ="${aws_subnet.subnetPublic3.id}"
}

output "subnet-private1" {
  value ="${aws_subnet.subnetPrivate1.id}"
}

output "subnet-private2" {
  value ="${aws_subnet.subnetPrivate2.id}"
}

output "subnet-private3" {
  value ="${aws_subnet.subnetPrivate3.id}"
}

output "internet-gatway"{
  value ="${aws_internet_gateway.igw.id}"
}

output "route-table-public"{
  value ="${aws_route_table.routeTablePublic.id}"
}

output "route-table-private"{
  value ="${aws_route_table.routeTablePrivate.id}"
}


