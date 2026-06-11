# Lab 04: Creating IAM Resources

## 📋 Objective
Implement Identity and Access Management (IAM) permissions based on the Principle of Least Privilege (PoLP) by designing granular execution boundaries for compute instances interacting with Amazon S3.

## 🛠️ Infrastructure Components
* **IAM Group:** Group partition mapping automated platform management definitions.
* **Custom IAM Policy:** Explicit write permissions (`s3:PutObject`, `s3:DeleteObject`) scoped directly to a specific bucket via `templatefile()`.
* **IAM Role & Instance Profile:** Trust relationships for the EC2 service boundary (`ec2.amazonaws.com`), establishing an attached access context without hardcoded credentials.

## 📂 File Structure
* `main.tf` – Core infrastructure provider blocks.
* `iam.tf` – Groups, policies, roles, attachments, and instance profile configurations.
* `policy.json` – Parametrized JSON policy document template.
* `variables.tf` – Input validation bindings.
* `terraform.tfvars` – Platform S3 and resource definitions.
* `versions.tf` – Lock constraints for provider software.
* `outputs.tf` – IAM Instance Profile parameters.
