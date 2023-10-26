variable "number_example" {
  description = "This is a example of a number variable"
  type        = number
  default     = 43
}

variable "list_example" {
  description = "This is a example of a list variable"
  type        = list(any)
  default     = ["Malik", "Cameron", "Chloe"]
}

variable "list_numeric_example" {
  description = "This is a example of a numeric list variable"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "map_example" {
  description = "This is a example of a map variable"
  type        = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
    key3 = "value3"
  }
}

variable "object_example" {
  description = "This is a example of a structural type in Terraform"
  type = object({
    name    = string
    age     = number
    tags    = list(string)
    enabled = bool
  })

  default = {
    name = "Malik"
    age  = 27
    tags = ["Software-Engineer", "DevOps-Engineer", "Baseball-Player"]
  }
}

