# 接続先サービス情報
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source = "modules/vpc/"
}

module "security_group" {
  source = "modules/security_group/"
  vpc_id = "${module.vpc.vpc_id}"
}

module "ec2" {
  source            = "modules/compute/ec2/"
  key_name          = "${var.key_name}"
  subnet_id         = "${module.vpc.subnet_id}"
  security_group_id = "${module.security_group.security_group_id}"
}