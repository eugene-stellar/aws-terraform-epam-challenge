output "iam_instance_profile_id" {
  description = "Provides IAM instance profile ID."
  value       = aws_iam_instance_profile.iam_instance_profile.id
}