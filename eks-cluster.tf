provider "kubernetes" {
    #load_config_file = "false"
    host = data.aws_eks_cluster.app-cluster.endpoint
    token = data.aws_eks_cluster_auth.app-cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.app-cluster.certificate_authority.0.data)
}

data "aws_eks_cluster" "app-cluster" {
    name = module.eks.cluster_name
    depends_on = [module.eks]
}


data "aws_eks_cluster_auth" "app-cluster" {
    name = module.eks.cluster_name
    depends_on = [module.eks]
}
output "cluster_id" {
  value = data.aws_eks_cluster.app-cluster.id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.21"

  cluster_name    = "app-eks-cluster"
  cluster_version = "1.29"

  vpc_id     = module.myapp-vpc.vpc_id
  subnet_ids = module.myapp-vpc.private_subnets

  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t3.small"]
      key_name       = "may_key"
    }
  }

  tags = {
    environment = "development"
    application = "app"
  }

  depends_on = [module.myapp-vpc]
}
