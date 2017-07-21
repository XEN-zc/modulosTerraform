##variable input##:
[required]
cidr_block_vpc   
cidr_block_subnet1
cidr_block_subnet2
cidr_block_subnet3
cidr_block_subnet4
cidr_block_subnet5
cidr_block_subnet6

[opcional]
name-vpc
instance_tenancy
assign_generated_ipv6_cidr_block
availability_zone
name-public-subnet1
name-public-subnet2
name-public-subnet3
name-private-subnet1
name-private-subnet2
name-private-subnet3
name-internet-gatway
eip-vpc
cidr_block_gateway
name-table-public
name-table-private 

#-------------------------------------------
##variable output##(here are ids of resources):
vpc
subnet-public1
subnet-public2
subnet-public3
subnet-private1
subnet-private2
subnet-private3
internet-gatway
eip
nat-gatway
route-table-public
route-table-private

