provider "aws" {
  region = var.region
}

# Frontend EC2 Instance
resource "aws_instance" "frontend" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.app_name}-frontend"
  }

  # Security Group
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_security_group" "web_sg" {
  name        = "${var.app_name}-web-sg"
  description = "Allow web traffic"

  ingress {
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
}

# Backend RDS Instance
resource "aws_db_instance" "backend" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "${var.app_name}_db"
  username             = var.admin_user
  password             = var.admin_password
  publicly_accessible  = false
}
