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
  #モジュール内でグローバルな変数を使う場合はここで引数にして渡す
  key_name = "aws_ono-hiroshi"
}