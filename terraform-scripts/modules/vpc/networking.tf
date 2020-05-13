resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr
}

output "subnet_id" {
  value = "${aws_subnet.main.id}"
}
