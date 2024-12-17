output "address" {
  value = aws_instance.ec2.*.public_dns
  description = "Retorna o endereço DNS público da instância criada"
  # O atributo "value" especifica o que será retornado como parte da saída.
  # Neste caso, está usando o recurso da instância EC2 da AWS chamado "ec2".
  # A sintaxe ".*" é usada para recuperar os nomes DNS públicos de todas as instâncias EC2 criadas.
  
  # "public_dns" fornece o endereço DNS público para cada instância EC2.
  # Isso é especialmente útil para acessar suas instâncias EC2 pela internet.
  
  # Se você tiver várias instâncias, isso retornará uma lista de seus endereços DNS públicos.
  # Se houver apenas uma instância, retornará o endereço DNS público dessa instância como um único item.
  
  # As saídas podem ser visualizadas após executar `terraform apply`, e também podem ser usadas em outros módulos
}

output "ec2_public_ip" {
  description = "Endereço IP público da instância EC2"
  value       = aws_instance.ec2.public_ip
}
