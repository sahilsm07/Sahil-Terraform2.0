variable "region" {
  default = "ap-south-1"
}

variable "vpc-cidr" {
  default = "10.22.0.0/16"
}

variable "azs" {
  type = list
  default = ["ap-south-1a" , "ap-south-1b"]
}

variable "prod-private-subnets" {
  type = list
  default = ["10.22.8.0/24" , "10.22.9.0/24"]
}

variable "prod-public-subnets" {
  type = list
  default = ["10.22.16.0/24" , "10.22.17.0/24"]
}

#for_each loop testing
variable "public-subnets" {
  type = list
  default = ["20.20.20.0/24"  , "40.40.40.0/24", "30.30.30.0/24", "50.50.50.0/24"]
}

variable "aws_s3_tag"{
    type=map(any)
}