resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-ap-northeast-3a.id

  tags = {
    Name = "coreCube"
    Service = "application1"
    Owner = "Mcguffinn"
    Location = "Osaka"
  }

  depends_on = [aws_internet_gateway.igw]
}
