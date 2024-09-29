provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "app_instance" {
  ami           = "ami-0b45ae66668865cd6"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              docker run -d -p 3000:3000 devops-app
  EOF

  tags = {
    Name = "Jenkins-project"
  }
}
