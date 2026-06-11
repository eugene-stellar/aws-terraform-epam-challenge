# Lab 02: Resources for SSH Authentication

## 📋 Objective
Provision a secure compute environment by deploying a public Amazon EC2 instance authenticated via custom SSH key pairs, leveraging Terraform data sources to discover pre-existing cloud landing zones.

## 🛠️ Infrastructure Components
* **SSH Key Pair:** Registration of a custom public key within AWS for cryptographic instance access.
* **EC2 Instance:** A `t2.micro` compute node launched dynamically within an existing public subnet discoverable via metadata.
* **Data Sources:** Abstracted queries targeting pre-created platform assets (VPC, Subnet, and Security Group boundaries).

## 📂 File Structure
* `main.tf` – Provider requirements.
* `ssh.tf` – AWS Key Pair configuration mapping external public keys.
* `ec2.tf` – Data discovery filters and EC2 virtual machine resource blocks.
* `variables.tf` – Input schemas (including `ssh_key` passed securely via environment variables).
* `terraform.tfvars` – Non-sensitive infrastructure identifiers.
* `versions.tf` – Strict provider semantic constraints.
* `outputs.tf` – Exposed runtime metrics (Instance ID, Public IP).
