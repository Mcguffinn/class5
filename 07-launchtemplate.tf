resource "aws_launch_template" "coreCube_LT" {
  name_prefix   = "coreCube_LT"
  image_id      = "ami-035322b237ca6d47a"  
  instance_type = "t2.micro"

  key_name = "coreCubeBox"

  vpc_security_group_ids = [aws_security_group.coreCube-sg01-servers.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd

    # Get the IMDSv2 token
    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    # Background the curl requests
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
    wait

    macid=$(cat /tmp/macid)
    local_ipv4=$(cat /tmp/local_ipv4)
    az=$(cat /tmp/az)
    vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macid/vpc-id)

    # Create HTML file
    cat <<-HTML > /var/www/html/index.html
    <!doctype html>
    <html lang="en" class="h-100">
    <head>
    <title>Edwins Dojo</title>
    </head>
    <body>
    <div>
    <img src="https://newbucketsmay30.s3.amazonaws.com/Leonardo_Vision_XL_A_black_male_man_in_samurai_armor_under_a_s_0.jpg" alt="dope dude">
    <h1>Solo Dolo</h1>
    <h1>Chains Demolished in Osaka</h1>
    <p><b>Instance Name:</b> $(hostname -f) </p>
    <p><b>Instance Private Ip Address: </b> $local_ipv4</p>
    <p><b>Availability Zone: </b> $az</p>
    <p><b>Virtual Private Cloud (VPC):</b> $vpc</p>
    </div>
    </body>
    </html>
    HTML

    # Clean up the temp files
    rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "coreCube"
      Service = "application1"
      Owner = "Mcguffinn"
      Location = "Osaka"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
