variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "MyEC2Instance"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0f5d1713c9af4fe30"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}
