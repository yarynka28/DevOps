#Output of public IP of AWS instance
output "AWS_public_IP" {
  value = module.AWS.public_ip
}

#Output of public IP of Azure instance
output "Azure_public_IP" {
  value = module.Azure.public_ip
}
