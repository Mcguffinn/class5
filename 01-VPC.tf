# this  makes  vpc.id which is aws_vpc.coreCube.id
resource "aws_vpc" "coreCube" {
  cidr_block = "10.32.0.0/16"

  tags = {
    Name = "coreCube"
    Service = "application1"
    Owner = "Mcguffinn"
    Location = "Osaka"
  }
}
