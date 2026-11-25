provider "aws" {
  region = var.region
}

# Security group para las instancias EC2
resource "aws_security_group" "mi-sg-efs-instancias-14" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security group creado con Terraform"
  vpc_id      = "vpc-0e8eef941e0d368ae"

  # Regla de entrada para SSH
}

# Security group para EFS 
resource "aws_security_group" "mi-sg-efs-14" {
  name        = "mi-security-group-terraform-efs"
  description = "Security group creado con Terraform"
  vpc_id      = "vpc-0e8eef941e0d368ae"

 
}
#Reglas SG Instancias
#Reglas de entrada:
#Entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 =  "0.0.0.0/0"
}
#Salida
#Salida a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id#Atributo para establecer el destino
}
#Salida a internet all traffic
provider "aws" {
  region = var.region
}

# Security group para las instancias EC2
resource "aws_security_group" "mi-sg-efs-instancias" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security group creado con Terraform"
  vpc_id      = "vpc-0e8eef941e0d368ae"

  # Regla de entrada para SSH
}

# Security group para EFS 
resource "aws_security_group" "mi-sg-efs" {
  name        = "mi-security-group-terraform-efs"
  description = "Security group creado con Terraform"
  vpc_id      = "vpc-0e8eef941e0d368ae"

 
}
#Reglas SG Instancias
#Reglas de entrada:
#Entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancias.id
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 =  "0.0.0.0/0"
}
#Salida
#Salida a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id#Atributo para establecer el destino
}
#Salida a internet all traffic
resource "aws_vpc_security_group_egress_rule" "salida_internet" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol = "-1" #-1 para la salida a internet
  cidr_ipv4 = "0.0.0.0/0" #Destino

}


#Reglas SG EFS
#Entrada
#Regla entrada EFS
resource "aws_vpc_security_group_ingress_rule" "entrada_efs" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id #Origen
}
#Salida


# Declaracion de los recursos de aws
resource "aws_instance" "mi_instancia_efs" {
  ami                    = var.ami_id
  instance_type          = var.tipo_instancia
  key_name               = var.nombre_llave
  count                  = var.cantidad_instancias
  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id]

  tags = {
    Name = "MiInstanciaEfs - ${count.index + 1}"
  }
}
#Reglas SG EFS
#Entrada
#Salida

