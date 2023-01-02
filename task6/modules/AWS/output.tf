#Output of public ip of AWS instance
output "public_ip" {
  value = aws_instance.grafana_instance.public_ip
}
