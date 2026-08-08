variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "azs" {
  description = "The availability zones for the subnets"
  type        = list(string)
  default     = ["ca-central-1a", "ca-central-1b"]
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true

}

variable "my_ip" {
  description = "Your public IP for SSH access, in CIDR format (e.g. 203.0.113.45/32)"
  type        = string
  sensitive   = true
}