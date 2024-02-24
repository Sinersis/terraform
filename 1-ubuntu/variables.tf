variable "name" {
  type    = list(string)
  default = ["sandbox_one", "sandbox_two", "sandbox_three"]
}

variable "image" {
  type = string
  default = "ubuntu:latest"
}