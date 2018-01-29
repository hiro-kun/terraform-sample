# VPC作成
resource "aws_vpc" "default-vpc" {
  cidr_block = "192.168.0.0/16"
  tags {
    Name = "terraform-vpc"
  }
}

# サブネット作成
resource "aws_subnet" "default-vpc-public-subnet1" {
  vpc_id            = "${aws_vpc.default-vpc.id}"
  cidr_block        = "192.168.1.0/24"
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

# セキュリティグループ作成
resource "aws_security_group" "web" {
  name   = "web"
  vpc_id = "${aws_vpc.default-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "web"
  }
}