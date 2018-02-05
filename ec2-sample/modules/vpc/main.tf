# VPC作成
resource "aws_vpc" "default-vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  tags {
    Name = "terraform-vpc"
  }
}

# サブネット作成
resource "aws_subnet" "default-vpc-public-subnet1" {
  vpc_id            = "${aws_vpc.default-vpc.id}"
  cidr_block        = "${var.subnet_cidr_block}"
  availability_zone = "ap-northeast-1a"

  tags {
    Name = "default-vpc-public-subnet1"
  }
}

# インターネットゲートウェイ作成
resource "aws_internet_gateway" "default-vpc-igw" {
  vpc_id = "${aws_vpc.default-vpc.id}"

  tags {
    Name = "default-vpc-igw"
  }
}

# ルートテーブル作成
resource "aws_route_table" "default-vpc-public-rt" {
  vpc_id = "${aws_vpc.default-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default-vpc-igw.id}"
  }

  tags {
    Name = "default-vpc-public-rt"
  }
}

# ルートテーブルとサブネットの紐付け
resource "aws_route_table_association" "default-vpc-rta-1" {
  subnet_id      = "${aws_subnet.default-vpc-public-subnet1.id}"
  route_table_id = "${aws_route_table.default-vpc-public-rt.id}"
}