variable "region"{
    #default = "us-east-2"
    default = "us-east-1"

}

variable "aws_ubuntu_awis"{
    default = {
        #"us-east-2" = "ami-0f7919c33c90f5b58" #Amazon Linux 2 AMI
        #"us-east-2" ="ami-07c1207a9d40bc3bd" #Ubuntu Server 18.04 LTS
        #"us-east-1" = "ami-085925f297f89fce1" # AWS EDUCATE Ubuntu Server 18.04 LTS
        "us-east-1" = "ami-0885b1f6bd170450c" # AWS EDUCATE Ubuntu Server 20.04 LTS
        #"us-east-1" = "ami-096fda3c22c1c990a" # AWS EDUCATE #Red Hat Enterprise Linux 8
        #"us-east-2" ="ami-0a54aef4ef3b5f881" #Red Hat Enterprise Linux 8
    }
}

variable "environment"{
    type = "string"
}

variable "application" {
    type = "string"
}

variable "key_name" {
    type = "string"
    default = "MyKeyPair"
}

variable "mgmt_ips" {
    default = "0.0.0.0/0"
}
variable "public_key" {
  default = "~/.ssh/MyKeyPair.pub"
}
variable "private_key" {
  default = "~/.ssh/MyKeyPair.pem"
}
variable "ansible_user" {
  default = "ubuntu"
  #default = "ec2-user"
}