# resource "aws_ecs_task_definition" "my_first_task" {
#   family                   = "my-first-task" # Naming our first task
# #   task_role_arn            = aws_iam_role.ecs_task_role.arn 
#   container_definitions    = <<DEFINITION
#   [
#     {
#       "name": "my-first-task",
#       "image": "${aws_ecr_repository.erc-repo.repository_url}",
#       "essential": true,

#     "environment": [
#       {"name": "MONGO_URL", "value": "mongo.golang-mongo"}
#     ],

#       "portMappings": [
#         {
#           "containerPort": 5500,
#           "hostPort": 5500
#         }
#       ],
#       "memory": 512,
#       "cpu": 256
#     }
#   ]
#   DEFINITION
#   requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
#   network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
#   memory                   = 512         # Specifying the memory our container requires
#   cpu                      = 256         # Specifying the CPU our container requires
#   execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
# }

# Production golang task
resource "aws_ecs_task_definition" "golang-task" {
  family                   = "golang" # Naming our first task
#   task_role_arn            = aws_iam_role.ecs_task_role.arn 
  container_definitions    = <<DEFINITION
  [
    {
      "name": "golang",
      "image": "${aws_ecr_repository.erc-repo.repository_url}",
      "essential": true,

    "environment": [
      {"name": "MONGO_URL", "value": "mongo.prod-golang-mongo"}
    ],

      "portMappings": [
        {
          "containerPort": 5500,
          "hostPort": 5500
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
    # policy_arn = aws_ecs_task_definition.my_first_task.id
}   

# Production 
resource "aws_ecs_task_definition" "mongo_task" {
  family                   = "mongo-tf" # Naming our first task
#   task_role_arn            = aws_iam_role.ecs_task_role.arn 
  container_definitions    = <<DEFINITION
  [
    {
      "name": "mongo",
      "image": "${aws_ecr_repository.mongo-erc-repo.repository_url}",
      "essential": true,
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  runtime_platform {
    operating_system_family = "LINUX"
  }
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}