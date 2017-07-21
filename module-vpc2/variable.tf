######### bloque variables  ###########
#-------------------------
	###para vpc
variable "cidr_block_vpc"{} 

variable "instance_tenancy"{
	default="default"
}

variable "assign_generated_ipv6_cidr_block"{
	default="false"
}

variable "name-vpc"{
	default="my-vpc"
}

#-----------------------------------
	###para subnet

variable "cidr_block_subnet1"{}
variable "cidr_block_subnet2"{}
variable "cidr_block_subnet3"{}
variable "cidr_block_subnet4"{}
variable "cidr_block_subnet5"{}
variable "cidr_block_subnet6"{}

variable "availability_zone"{
     default="eu-west-1a"
}


variable "name-public-subnet1"{
	default="public subnet1"
}
variable "name-public-subnet2"{
	default="public subnet2"
}
variable "name-public-subnet3"{
	default="public subnet3"
}
variable "name-private-subnet1"{
	default="private subnet1"
}
variable "name-private-subnet2"{
	default="private subnet2"
}
variable "name-private-subnet3"{
	default="private subnet3"
}

#-------------------------------
	### para gateway
variable "name-gatway"{
	default="my-internet-gateway"
}

#-------------------------------
	###para elastic ip
variable "vpc"{
	default="true"
}	

#-------------------------------
	#para route table
variable "name-table-public"{
	default="route-table-public"
}

variable "cidr_block_gateway"{
	default="0.0.0.0/0"
}

variable "name-table-private"{
	default="route-table-private"
}


