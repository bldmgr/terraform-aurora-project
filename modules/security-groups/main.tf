resource "aws_security_group" "aurora_sg" {
  name        = var.db_security_group_name
  description = "Security group for Aurora PostgreSQL database"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "aurora_security_group_id" {
  value = aws_security_group.aurora_sg.id
}