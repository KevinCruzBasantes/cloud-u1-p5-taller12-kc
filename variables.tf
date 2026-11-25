#region donde despliegan los recursos
variable "region" {
  description = "The AWS region"
  type = string
  default = "us-east-1" #se tiene un valor por defecto para si el usuario no ingresa algun valor tenga un valor ya asignado
}
variable "ami_id" {
  description = "Id de la AMI "
  type = string
  default = "ami-00f43ee0e98d52529"
}
variable "tipo_instancia" {
    description = "Tipo instancia"
    type = string
    default = "t2.micro"
}
variable "nombre_llave" {
    description = "Mi llave"
    type = string
    default = "mi-clave"
}
variable "cantidad_instancias" {
    description = "Cantidad instancias"
    type = number
    default = 2

}
