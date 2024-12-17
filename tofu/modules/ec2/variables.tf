variable "most_recent_ami" {
  description = "Defina como verdadeiro para obter a AMI mais recente que corresponda aos filtros especificados."
  type        = bool
}

variable "ami_name_pattern" {
  description = "O padrão usado para corresponder ao nome da AMI (por exemplo, para Ubuntu 22.04). Modifique isso para alterar o sistema operacional ou a versão."
  type        = string
}

variable "virtualization_type" {
  description = "Especifica o tipo de virtualização para a AMI (por exemplo, hvm ou paravirtual). HVM é normalmente usado para instâncias modernas."
  type        = string
}

variable "ami_owners" {
  description = "Uma lista de IDs de contas AWS que possuem a AMI. Por padrão, usa o ID da Canonical para AMIs oficiais do Ubuntu. Você pode modificar isso para usar AMIs personalizadas ou de terceiros."
  type        = list(string)
  default = [ "hvm" ]
}

variable "ec2_ami_id" {
  description = "O ID da Amazon Machine Image (AMI) usado para iniciar a instância EC2. Uma AMI é um modelo pré-configurado que contém o sistema operacional e outros softwares necessários para executar a instância. (por exemplo, 'Ubuntu Server 22.04 LTS' para ambientes baseados em Linux)"
  type        = string
}

variable "ec2_instance_type" {
  description = "Configuração de hardware para a instância EC2. Isso especifica a quantidade de CPU, RAM e desempenho de rede. Tipos comuns incluem 't2.micro' (nível gratuito, cargas de trabalho pequenas) e 't3.medium' (uso geral, cargas de trabalho moderadas)."
  type        = string
}

variable "ec2_vpc_id" {
  description = "ID da VPC (Virtual Private Cloud) onde a instância EC2 será implantada. Esta é uma rede isolada onde todos os nossos recursos estarão conectados, permitindo que se comuniquem entre si (mais sobre isso na parte dos grupos de segurança)."
  type        = string
}

variable "ec2_key_name" {
  description = "O nome da chave para autenticação SSH Key Pair, será usado principalmente para conexões SSH na sua instância EC2, gerando um arquivo .pem que deve ser salvo em um local seguro."
  type        = string
}

variable "availability_zone" {
  description = "A zona de disponibilidade na qual lançar a instância EC2 (por exemplo, us-east-1a, sa-east-1)"
  type        = string
}

variable "ec2_associate_public_ip_address" {
  description = "Flag booleana para associar um endereço IP público à instância EC2, será usado na configuração do domínio posteriormente."
  type        = bool
}

variable "ec2_security_groups_ids" {
  description = "Lista de IDs de grupos de segurança a serem associados à instância EC2, configurando os tipos de conexões e permissões disponíveis para nossa instância."
  type        = list(string)
}

variable "ec2_root_volume_size" {
  description = "Tamanho do volume raiz da instância EC2 em GB"
  type        = number
}

variable "ec2_root_volume_type" {
  description = "O tipo do volume raiz (por exemplo, gp2, io1)"
  type        = string
}

variable "ec2_tag_platform" {
  description = "Tag para identificar a plataforma da instância EC2 (por exemplo, Linux/Ubuntu)"
  type        = string
}
