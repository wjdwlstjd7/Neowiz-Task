variable "region" {
  description = "사용하는 리전"
  type = map(string)
  default = {
    an2 = "ap-northeast-2"
  }
}
variable "region_code" {
  description = "사용하는 리전 code"
  type = string
  default = "an2"
}
variable "azs" {
  description = "사용하는 가용영역"
  type = list(string)
  default = [
    "a",
    "c"
  ]
}

# Network
variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 public subnet cidr 목록"
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_subnet_cidr_list" {
  type = list(string)
  description = "생성될 VPC의 private subnet cidr 목록"
  default = ["10.0.20.0/24", "10.0.21.0/24"]
}

## EC2
variable "instance_type" {
  type        = string
  default     = "r6i.large"
  description = "EC2 instance type for Windows Server"
}

variable "root_volume_type" {
  type        = string
  default     = "gp3"
  description = "Volumen type of root volumen of Windows Server."
}

variable "private_ip" {
  type = list(string)
  default = ["10.0.20.20"]
  description = "EC2 Network interface Private IP"
}

variable "key_name" {
  type = string
  default = "jjung_key"
  description = "Key Name"
}

variable "sg_egress" {
  type = list(string)
  default = ["0.0.0.0/0"]
}