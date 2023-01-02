variable "key_name" {
  default = "id_rsa"
}

variable "ssh_key" {
  default = "id_rsa.pub"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-00b3e95ade0a05b9b"
}

variable "grafana" {
  default = "grafana.sh"
}
