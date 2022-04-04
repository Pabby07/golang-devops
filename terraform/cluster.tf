# resource "aws_ecs_cluster" "golang-cluster" {
#   name = "golang-cluster" # Naming the cluster
# }

resource "aws_ecs_cluster" "prod-cluster" {
  name = "prod" # Naming the cluster
}