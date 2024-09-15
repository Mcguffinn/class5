resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.coreCube.id

  tags = {
    Name    = "coreCube"
    Service = "application1"
    Owner = "Mcguffinn"
    Location = "Osaka"
  }
}
