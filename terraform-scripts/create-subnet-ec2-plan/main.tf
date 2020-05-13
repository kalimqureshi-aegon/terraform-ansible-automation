provider "aws" {
  region = "ap-south-1"
}

module "my_vpc" {
  source      = "../modules/vpc"
  vpc_id      = "vpc-0d33961a622bb6b3e"
  subnet_cidr = "10.22.10.0/24"
}

module "my_ec2" {
  source        = "../modules/ec2"
  ami_id        = "ami-00f4cff050d28ee2d"
  instance_type = "t2.micro"
  subnet_id     = module.my_vpc.subnet_id
}