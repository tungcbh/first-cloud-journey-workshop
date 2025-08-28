#subnet_group
resource "aws_db_subnet_group" "default" {
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet.private.*.id

  tags = {
    Name = "rds_subnet_group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier        = "mysql-instance"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  backup_retention_period = 7
  backup_window           = "20:00-21:00"

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds-security-group.id]

  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true

  tags = {
    Name = "mysql-instance"
  }
}
