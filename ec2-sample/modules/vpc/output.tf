output "subnet_id" {
    value = "${aws_subnet.default-vpc-public-subnet1.id}"
}

output "security_group_id" {
    value = "${aws_security_group.web.id}"
}