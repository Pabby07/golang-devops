# resource "aws_s3_bucket" "lb_logs" {
#   bucket = "golang-alb-logs-bucket"

# #   tags = {
# #     Name        = "My bucket"
# #     Environment = "Dev"
# #   }
# }

# resource "aws_iam_policy" "s3_access_policy" {
#   name        = "test-policy"
#   description = "A test policy"

#   policy = <<EOF
#     {
#     “Version”: “2012-10-17”,
#     “Statement”: [
#     {
#     “Effect”: “Allow”,
#     “Principal”: {
#     “AWS”: “arn:aws:iam::783225319266:root”
#     },
#     “Action”: “s3:PutObject”,
#     “Resource”: “arn:aws:s3:::golang-alb-logs-bucket/*”
#     }
#     ]
#     }
#     EOF
# }


