provider "aws" {
    region = var.region
  
}
#Creamos el security group para la instancia
resource "aws_security_group" "mi-sg-efs-instancias" {
    name = "mi-security-group-terraform-efs-instancias"
    description = "Security group creado con Terraform"
    vpc_id = "vpc-0f159688cebf48cdc"

#Regla de entrada para SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
#Regla de salida para internet
    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 2049
        to_port = aws_security_group.mi-sg-efs
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Creamos el security group para el efs
resource "aws_security_group" "mi-sg-efs" {
    name = "mi-security-group-terraform-efs"
    description = "Security group creado con Terraform"
    vpc_id = "vpc-0f159688cebf48cdc"

#Regla de entrada para SSH
    ingress {
        from_port = aws_security_group.mi-sg-efs-instancias
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
#Regla de salida para HTTP
    egress {
        from_port = 2049
        to_port = aws_security_group.mi-sg-efs-instancias
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
#Declaracion de los recursos de aws
resource "aws_instance" "mi_instancia_efs" {
    ami = var.ami_id 
    instance_type = var.tipo_instancia  
    key_name = var.nombre_llave 
    security_groups = [aws_security_group.mi-sg-efs-instancias.name]
    count = var.cantidad_instancias
    tags = {
        Name = "MiInstanciaEfs - ${count.index+1}"
    }
    vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias]
    
    
}