provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_instances" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"  # Use the instance_name for tagging
  }
}
