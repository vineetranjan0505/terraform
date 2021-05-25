provider "aws" {
	region = "us-east-2"
}

resource "aws_instance" "vineet-example" {
	ami = "ami-0c55b159cbfafe1f0"
	
	instance_type = "t2.micro"
	
	user_data = <<-EOF
		#!/bin/bash
		echo "Hello, World" > index.html 
		nohup busybox httpd -f -p 8080 &
		EOF
		
	vpc_security_group_ids = [aws_security_group.instance.id]
		
	tags = {
		Name = "vineet-example"
		}
}

resource "aws_security_group" "instance" {
	name = "vineet-terraform-example"
	
	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		}
}


	