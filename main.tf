module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.env}-${var.project_name}-vpc"
  cidr = var.cidr_blocks

  azs                 = [join("", [var.region, "a"]), join("", [var.region, "c"])]
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  database_subnets    = var.create_database_subnets ? var.database_subnets : []
  elasticache_subnets = var.create_elasticache_subnets ? var.elasticache_subnets : []

  enable_nat_gateway     = true
  enable_vpn_gateway     = false
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = var.enable_dns_hostnames

  tags = {
    # Name  = "${var.env}-${var.project_name}"
    Environment = "${var.env}"
    Management  = "terraform"
  }
}

resource "aws_vpc_endpoint" "s3gw_endpoint" {
  vpc_endpoint_type   = "Gateway"
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${var.region}.s3"
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
