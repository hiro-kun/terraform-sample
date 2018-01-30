# 接続先サービス情報
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source  = "modules/vpc/"
}

module "ec2" {
  source            = "modules/compute/ec2/"
  key_name          = "${var.key_name}"
  subnet_id         = "${module.vpc.subnet_id}"
  security_group_id = "${module.vpc.security_group_id}"
  #instance_type     = "${var.instance_type}"
}