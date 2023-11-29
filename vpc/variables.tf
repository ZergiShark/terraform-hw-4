variable "env_name" {
  type    = string
  description = "Название облачной сети"
}

variable "zone" {
  type    = string
  description = "Описание зоны подсети"
}

variable "cidr" {
  type    = string
  description = "CIDR-блок, определяющий диапазон IP-адресов для подсети"
}
