	####lista de recursos requeridos previamente####
##service-role-arn
##default_instance_profile_arn
##vpc
##subnet
##custom_security_group_ids

	######### bloque variables  ###########
#------------------------------------
#para proveedor de servicio 
variable "access_key" {}
variable "secret_key" {}
variable "region" {
	default="eu-west-1"
}

#------------------------------------
	####para stack ####
variable "name-stack"{
	default="xiao-stack"
}

variable "service-role-arn"{}

variable "default_instance_profile_arn"{}

variable "default_ssh_key_name" {
	default="xiao-prueba-keys"
}

variable "default_os"{
	default="Ubuntu 14.04 LTS"
}

variable "vpc_id"{}

variable "default_subnet_id"{}

variable "configuration_manager_version"{
	default="12"
}


variable "use_opsworks_security_groups"{
	default="false"
}

variable "use_custom_cookbooks"{
	default="true"
}

variable "repository_type"{
	default="git"
}

variable "repository_url"{
	default="https://github.com/x-chen4/pruebaChef.git"
}

#-------------------------------------
	####para layer####
variable "name_layer1"{
	default="frontEnd"
}

variable "name_layer2"{
	default="integration"
}

variable "name_layer3"{
	default="elasticSearch"
}

variable "custom_security_group_ids"{
	default=[]
}

variable "auto_assign_elastic_ips"{
	default="true"
}

variable "auto_assign_public_ips"{
	default="true"
}

variable "custom_setup_recipes"{
	default=["java_se",]
} 


#-------------------------------------
	#### para instance ####
variable "instance_type"{
	default="t2.micro"
}

variable "ami_id"{
	default="ami-d37961b5"
}

variable "os"{
	default="Custom"
}

variable "ssh_key_name"{
	default="xiao-prueba-keys"
}




#------------------------------------------------------------
########bloque Despliegue ########

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


#-----------------
resource "aws_opsworks_stack" "stack1" {
  name					="${var.name-stack}"
  region					="${var.region}"
  service_role_arn			="${var.service-role-arn}"
  default_instance_profile_arn  ="${var.default_instance_profile_arn}"
  default_ssh_key_name		="${var.default_ssh_key_name}"
  default_os				="${var.default_os}"
  vpc_id					="${var.vpc_id}"
  default_subnet_id			="${var.default_subnet_id}"
  configuration_manager_version  ="${var.configuration_manager_version }"
  use_opsworks_security_groups ="${var.use_opsworks_security_groups}"
  use_custom_cookbooks 		="${var.use_custom_cookbooks}"
  custom_cookbooks_source = {
  	url   ="${var.repository_url}"
  	type  ="${var.repository_type}"
  }
}

#-----------------
resource "aws_opsworks_custom_layer" "layer1"{
	name 				   ="${var.name_layer1}"
	short_name 		   ="layer1"
	stack_id 			   ="${aws_opsworks_stack.stack1.id}"
     	auto_assign_elastic_ips  ="${var.auto_assign_elastic_ips}"
	auto_assign_public_ips   ="${var.auto_assign_public_ips}"
	custom_security_group_ids ="${var.custom_security_group_ids}"
	custom_setup_recipes 	   ="${var.custom_setup_recipes }"
}

resource "aws_opsworks_custom_layer" "layer2"{
	name 				   ="${var.name_layer2}"
	short_name 	  	   ="layer2"
	stack_id 			   ="${aws_opsworks_stack.stack1.id}"
	auto_assign_elastic_ips  ="${var.auto_assign_elastic_ips}"
	auto_assign_public_ips   ="${var.auto_assign_public_ips}"
     custom_security_group_ids ="${var.custom_security_group_ids }"
	custom_setup_recipes 	   ="${var.custom_setup_recipes }"

}

resource "aws_opsworks_custom_layer" "layer3"{
	name 				="${var.name_layer3}"
	short_name 		="layer3"
	stack_id 			="${aws_opsworks_stack.stack1.id}"
	auto_assign_elastic_ips  ="${var.auto_assign_elastic_ips}"
	auto_assign_public_ips   ="${var.auto_assign_public_ips}"
     custom_security_group_ids ="${var.custom_security_group_ids}"

}

resource "aws_opsworks_instance" "instance1"{
	stack_id = "${aws_opsworks_stack.stack1.id}"
	layer_ids = ["${aws_opsworks_custom_layer.layer1.id}",]
 	instance_type = "${var.instance_type}"
  	os            = "${var.os}"
	ami_id	   = "${var.ami_id}"
  	state         = "stopped"
	ssh_key_name  = "${var.ssh_key_name}"
}

resource "aws_opsworks_instance" "instance2"{
	stack_id  	   = "${aws_opsworks_stack.stack1.id}"
	layer_ids     =["${aws_opsworks_custom_layer.layer2.id}",]
 	instance_type = "${var.instance_type}"
  	os            = "${var.os}"
	ami_id	   = "${var.ami_id}"
  	state         = "stopped"
	ssh_key_name  = "${var.ssh_key_name}"
}










