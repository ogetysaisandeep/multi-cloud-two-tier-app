output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_db_endpoint" {
  value = aws_db_instance.backend.endpoint
}
