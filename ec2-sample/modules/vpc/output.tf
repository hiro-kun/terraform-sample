output "vpc_id" {
    value = "${aws_vpc.default-vpc.id}"
}

output "subnet_id" {
    value = "${aws_subnet.default-vpc-public-subnet1.id}"
}