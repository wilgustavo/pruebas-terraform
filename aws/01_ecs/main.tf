
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
        values = ["hvs"]
    }

    owners = ["099720109477"]
}

output "name" {
    value = data.aws_ami.ubuntu.name
}
  
output "id" {
    value = data.aws_ami.ubuntu.id
}