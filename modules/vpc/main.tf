# Resources for the AWS Virtual Private Cloud Terraform module.

# Fetch AZs in the current region.
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_flow_log" "vpc" {
  log_destination      = var.log_destination
  log_destination_type = var.log_destination_type
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id

  tags = {
    Name        = "${var.key}-logs-vpc-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.key}-vpc-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.key}-vpc-igw-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_eip" "nat" {
  count      = var.az_count
  domain     = "vpc"
  depends_on = [aws_internet_gateway.this]

  tags = {
    Name        = "${var.key}-vpc-eip-${var.environment}-${format("%03d", count.index + 1)}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.key}-vpc-private-subnet-${var.environment}-${format("%03d", count.index + 1)}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
    Scope       = "private"
  }
}

resource "aws_subnet" "public" {
  count             = var.az_count
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, var.az_count + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.key}-vpc-public-subnet-${var.environment}-${format("%03d", count.index + 1)}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
    Scope       = "public"
  }
}

resource "aws_nat_gateway" "this" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public[*].id, count.index)
  allocation_id = element(aws_eip.nat[*].id, count.index)
  depends_on    = [aws_internet_gateway.this]

  tags = {
    Name        = "${var.key}-vpc-ngw-${var.environment}-${format("%03d", count.index + 1)}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.key}-vpc-route-table-private-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_route" "private" {
  count                  = var.az_count
  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = var.destination_cidr_block
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.key}-vpc-route-table-public-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Service     = var.service
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(aws_route_table.private[*].id, count.index)
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}
