
variable "ssh_key_path" {}
variable "vpc_id" {}
variable "region_id" {}
  

provider "aws" {
    region = var.region_id    
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]    
    }

    owners = ["099720109477"]
}

resource "aws_security_group" "allow_ssh" {
    name = "allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id = var.vpc_id
    
    ingress {
        description = "SSH from VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_ssh"
    }
  
}

output "name" {
    value = data.aws_ami.ubuntu.name
}
  
output "id" {
    value = data.aws_ami.ubuntu.id
}