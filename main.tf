  provider "aws" {
    region = var.region
  }

  module "label" {
    source = "cloudposse/label/null"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"
    namespace  = var.namespace
    name       = var.name
    stage      = var.stage
    delimiter  = var.delimiter
    attributes = compact(concat(var.attributes, list("cluster")))
    tags       = var.tags
  }

  locals {
    # The usage of the specific kubernetes.io/cluster/* resource tags below are required
    # for EKS and Kubernetes to discover and manage networking resources
    # https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html#base-vpc-networking
    tags = merge(var.tags, map("kubernetes.io/cluster/${module.label.id}", "shared"))

    # Unfortunately, most_recent (https://github.com/cloudposse/terraform-aws-eks-workers/blob/34a43c25624a6efb3ba5d2770a601d7cb3c0d391/main.tf#L141)
    # variable does not work as expected, if you are not going to use custom AMI you should
    # enforce usage of eks_worker_ami_name_filter variable to set the right kubernetes version for EKS workers,
    # otherwise the first version of Kubernetes supported by AWS (v1.11) for EKS workers will be used, but
    # EKS control plane will use the version specified by kubernetes_version variable.
    eks_worker_ami_name_filter = "amazon-eks-node-${var.kubernetes_version}*"
  }



  module "eks_cluster" {
    source = "cloudposse/eks-cluster/aws"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"
    namespace  = var.namespace
    stage      = var.stage
    name       = var.name
    attributes = var.attributes
    tags       = var.tags
    subnet_ids =  var.subnet_ids
    vpc_id     =  var.vpc_id

    kubernetes_version    = var.kubernetes_version
    oidc_provider_enabled = false


    region     = var.region  
  }
