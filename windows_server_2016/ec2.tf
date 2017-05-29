provider "aws" {
  region = "ap-northeast-1"
}

data "aws_ami" "windows_server_2016" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
}

data "aws_security_group" "default" {
  name = "default"
}

resource "aws_instance" "windows_server_2016" {
  ami = "${data.aws_ami.windows_server_2016.image_id}"
  vpc_security_group_ids = ["${data.aws_security_group.default.id}"]
  instance_type = "t2.medium"
  key_name = "default"
}

output "instance_id" {
  value = "${aws_instance.windows_server_2016.id}"
}

output "public_ip" {
  value = "${aws_instance.windows_server_2016.public_ip}"
}
