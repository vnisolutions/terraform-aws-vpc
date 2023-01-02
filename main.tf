module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env}-${var.project_name}-vpc"
  cidr = "10.10.0.0/16"

  azs                 = [join("", [var.region, "a"]), join("", [var.region, "c"])]
  private_subnets     = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets      = ["10.10.10.0/24", "10.10.11.0/24"]
  database_subnets    = ["10.10.50.0/24", "10.10.51.0/24"]
  elasticache_subnets    = ["10.10.60.0/24", "10.10.61.0/24"]

  enable_nat_gateway     = true
  enable_vpn_gateway     = false
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

    tags = {
        # Name  = "${var.env}-${var.project_name}"
        Environment = "${var.env}"
        Management  = "terraform"
  }
}

resource "aws_vpc_endpoint" "s3gw_endpoint" {
    vpc_endpoint_type = "Gateway"
    vpc_id = module.vpc.vpc_id
    service_name = "com.amazonaws.${var.region}.s3"
    private_dns_enabled = false

    tags = {
        Name = "s3_gateway_endpoint"
    }
}

resource "aws_vpc_endpoint_route_table_association" "gw_endpoint_route_private_association" {
  route_table_id  = module.vpc.private_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3gw_endpoint.id
}

resource "aws_vpc_endpoint_route_table_association" "gw_endpoint_route_public_association" {
  route_table_id  = module.vpc.public_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3gw_endpoint.id
}