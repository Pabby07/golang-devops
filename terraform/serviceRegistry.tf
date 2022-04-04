resource "aws_service_discovery_private_dns_namespace" "mongo-service-dns" {
  name        = "prod-golang-mongo"
#   description = "example"
  vpc         = aws_default_vpc.default_vpc.id
}

resource "aws_service_discovery_service" "mongo-service-discovery" {
  name = "mongo"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.mongo-service-dns.id

    dns_records {
      ttl  = 60
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

#   health_check_custom_config {
#     failure_threshold = 1
#   }
}