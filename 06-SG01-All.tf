resource "aws_security_group" "coreCube-sg01-servers" {
  name        = "coreCube-sg01-servers"
  description = "coreCube-sg01-servers"
  vpc_id      = aws_vpc.coreCube.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MyEvilBox"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "coreCube-sg01-servers"
    Service = "application1"
    Owner = "Mcguffinn"
    Location = "Osaka"
  }

}





resource "aws_security_group" "coreCube-sg02-LB01" {
  name        = "coreCube-sg02-LB01"
  description = "coreCube-sg02-LB01"
  vpc_id      = aws_vpc.coreCube.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "coreCube-sg02-LB01"
    Service = "application1"
    Owner = "Mcguffinn"
    Location = "Osaka"
  }

}
