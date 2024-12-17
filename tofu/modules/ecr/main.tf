# Bloco de recurso para o módulo de repositório Amazon ECR (Elastic Container Registry)
resource "aws_ecr_repository" "ecr" {
  # O nome do repositório ECR, passado como uma variável.
  name                 = var.repo_name
  
  # Especifica a mutabilidade das tags de imagem, utilizando a variável definida para isso.
  image_tag_mutability = var.image_tag_mutability

  # Configura o escaneamento de imagens ao enviar para o repositório, utilizando a variável definida para isso.
  image_scanning_configuration {
    scan_on_push = var.scan_on_push  # Habilita ou desabilita o escaneamento automático de imagens quando são enviadas para o repositório.
  }

  # Tags para fins organizacionais e de rastreamento de custos.
  tags = {
    Name     = var.repo_name  # Define a tag "Name" para o nome do repositório.
    Platform = var.platform    # Define a tag "Platform", indicando o ambiente (exemplo: produção, staging).
    Type     = "Service"      # Indica que este recurso é um serviço.
  }
}

# Bloco de recurso para a política do repositório ECR.
resource "aws_ecr_repository_policy" "ecr_policy" {
  # Especifica o repositório ao qual esta política será aplicada.
  repository = aws_ecr_repository.ecr.name

  # A política que governa o acesso ao repositório em formato JSON
  # Esta é a política de informações que será aplicada e usada para gerenciar o acesso nesta instância do ECR para os usuários IAM das contas AWS.
  policy = jsonencode({
    Version : "2008-10-17",  # Especifica a versão da linguagem da política.
    Statement : [
      {
        Sid : "ECR Repository policy",  # ID da declaração para identificar a política.
        Effect : "Allow",               # Permite as ações especificadas nesta política.
        Principal : "*",                # Aplica-se a todos os principais (usuários e serviços).
        Action : [
          # Lista das ações permitidas no repositório ECR.
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
      }
    ]
  })
}
