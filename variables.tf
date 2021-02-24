variable "cluster_name" {
  type        = string
  description = "AWS cluster_name"
  default = "computooleks"
}

variable "region" {
  type        = string
  description = "AWS cluster region"
  default = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the EKS cluster"
  default     = "vpc-df0751b1"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the cluster in"
  type        = list(string)
  default     = ["subnet-48218d63","subnet-fe035590"]
}
variable "kubernetes_version" {
  type        = string
  description = "kubernetes_version"
  default     = "1.18"
}

