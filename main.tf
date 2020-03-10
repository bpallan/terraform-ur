provider "aws" {
    region = "us-west-2"
    
    # Allow any 2.x version of the AWS provider
    version = "~> 2.0"
}

resource "aws_instance" "example" {
  ami                    = "ami-0edf3b95e26a682df"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {

  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description   = "The port the service will use for HTTP requests"
  type          = number
  default       = 8080
}

output "public_ip" {
  value         = aws_instance.example.public_ip
  description   = "The public ip address of the web server"
}
