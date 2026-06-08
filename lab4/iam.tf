resource "aws_iam_group" "iam_group" {
  name = var.iam_group_name
}

resource "aws_iam_policy" "iam_policy" {

  name = var.iam_policy_name

  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.s3_bucket_name
  })

  tags = {
    Project = "cmtr-gy0ttqu8"
  }
}

resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "cmtr-gy0ttqu8"
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.iam_role.name

  tags = {
    Project = "cmtr-gy0ttqu8"
  }
}