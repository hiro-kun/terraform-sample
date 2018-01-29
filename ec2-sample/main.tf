variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "key_name" {}

# 接続先サービス情報
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "app" {
  source  = "modules/compute/ec2/"
  key_name = "hoge"
}