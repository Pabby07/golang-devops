resource "aws_ecr_repository" "erc-repo" {
  name                 = "golang-repo"
}

resource "aws_ecr_repository" "mongo-erc-repo" {
  name                 = "mongo-repo"
}

# output "ecr-repo-url" {
#   value = "${aws_ecr_repository.erc-repo.repository_url}"
# }