variable "env" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "project_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "region" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Name to be used on all the resources as identifier"
  type        = bool
  default     = false
}

variable "cidr_blocks" {
  description = "The IP blocks for the vpc cidr"
  type        = string
  default     = "10.10.0.0/16"
}

variable "private_subnets" {
  description = "The IP blocks for the private subnet"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "public_subnets" {
  description = "The IP blocks for the public subnet"
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.11.0/24"]
}

variable "database_subnets" {
  description = "The IP blocks for the database subnet"
  type        = list(string)
  default     = ["10.10.50.0/24", "10.10.51.0/24"]
}

variable "elasticache_subnets" {
  description = "The IP blocks for the elasticache subnet"
  type        = list(string)
  default     = ["10.10.60.0/24", "10.10.61.0/24"]
}

variable "create_database_subnets" {
  description = "Name to be used on all the resources as identifier"
  type        = bool
  default     = true
}

variable "create_elasticache_subnets" {
  description = "Name to be used on all the resources as identifier"
  type        = bool
  default     = false
}
