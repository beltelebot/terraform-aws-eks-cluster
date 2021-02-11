variable "cluster_name" {
  type        = string
  description = "AWS cluster_name"
  default = "computool-eks"
}


variable "vpc_id" {
  type        = string
  description = "VPC ID for the EKS cluster"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the cluster in"
  type        = list(string)
  
}

