output "ids_instancias" {
    description = "Ids de las instancias creadas"
    value = aws_instance.mi_instancia_efs[*].id

}
output "cantidad_instancias" {
  description = "Cantidad de instancias creadas"
  value = length(aws_instance.mi_instancia_efs) 
  #otra forma no funciona el conut no es un atributo
  #aws_instance.mi_instancia_efs.count

}
output "ip_publica_instancia" {
  description = "IPs publicas de la instancia"
  value = aws_instance.mi_instancia_efs[*].public_ip
}
output "zonas_disponibles" {
  description = "Zonas de disponibilidad de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].availability_zone
}