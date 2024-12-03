output "instance_public_ip" {
  value       = aws_instance.web_app.public_ip
  description = "Public IP of the EC2 instance"
}

output "web_app_url" {
  value       = "http://${aws_instance.web_app.public_ip}"
  description = "URL to access the web application"
}
