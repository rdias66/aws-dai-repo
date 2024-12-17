variable "rds_monitoring_role_policy_arn" {
  description = "ARN da política gerenciada para Monitoramento Avançado do RDS, mais informações na documentação oficial da AWS, Console de Gerenciamento da AWS e na documentação do provedor Terraform (OpenTofu no nosso caso)"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

variable "environment" {
  description = "O ambiente de implantação (por exemplo, dev, staging, produção)"
  type        = string
}

variable "availability_zone" {
  description = "Define a zona de disponibilidade da AWS para a instância RDS, esta será a mesma variável para todo o IaC"
  type        = string
}

variable "db_allocated_storage" {
  description = "A quantidade de armazenamento (em gigabytes) a ser alocada inicialmente para o banco de dados, importante verificar os limites para o nível gratuito se esse for o objetivo"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "A quantidade máxima de armazenamento (em gigabytes) que pode ser alocada para o banco de dados"
  type        = number
}

variable "db_engine" {
  description = "Especifica o mecanismo do banco de dados (por exemplo, mysql, postgres)"
  type        = string
}

variable "db_engine_version" {
  description = "A versão do mecanismo do banco de dados a ser usada"
  type        = string
}

variable "db_parameter_group_name" {
  description = "O nome do grupo de parâmetros do DB a ser associado à instância"
  type        = string
}

variable "db_instance_class" {
  description = "O tipo de instância da instância RDS (por exemplo, db.t2.micro)"
  type        = string
}

variable "db_user" {
  description = "O nome de usuário para conexão a ser declarado nas variáveis de produção"
  type        = string
  sensitive   = true  # Marcar como sensível para evitar que apareça nos logs
}

variable "db_password" {
  description = "A senha para conexão a ser declarada nas variáveis de produção"
  type        = string
  sensitive   = true  # Marcar como sensível para evitar que apareça nos logs
}

variable "db_port" {
  description = "A porta usada para conexão ao banco de dados (o padrão geralmente é 3306)"
  type        = number
  sensitive   = true  # Marcar como sensível para evitar que apareça nos logs
}

variable "db_database" {
  description = "O nome do banco de dados inicial a ser criado"
  type        = string
}

variable "db_backup_retention_period" {
  description = "O número de dias para reter backups"
  type        = number
}

variable "db_monitoring_interval" {
  description = "O intervalo, em segundos, entre os pontos quando as métricas de Monitoramento Avançado são coletadas, quanto mais curto, mais caro. Isso fornecerá dados mais granulares, o que pode afetar o preço."
  type        = number
}

variable "db_multi_az" {
  description = "Especifica se a instância RDS é multi-AZ, isso implantará a instância do banco de dados em várias zonas de disponibilidade, o que pode aumentar o preço. Para o nível gratuito, false é melhor"
  type        = bool
}

variable "db_publicly_accessible" {
  description = "Controle booleano para definir se a instância é acessível publicamente"
  type        = bool
}

variable "db_storage_encrypted" {
  description = "Habilita criptografia em repouso, isso não afeta como você consumirá e usará esta instância, mas pode levar a aumentos de preço. Se o custo eventual não for um problema, sempre defina como true"
  type        = bool
  default     = false
}

variable "db_storage_type" {
  description = "Um dos 'standard', 'gp2' ou 'io1', isso afeta o desempenho e o preço. Standard é melhor para o nível gratuito e os seguintes, gp2 e io1, aumentam o desempenho e o preço respectivamente. (Ambos são baseados em SSD)"
  type        = string
}

variable "db_tag_platform" {
  description = "Tag para identificar a plataforma"
  type        = string
}

variable "db_security_groups_names" {
  description = "Uma lista de nomes de grupos de segurança a serem atribuídos à instância"
  type        = list(string)
}
