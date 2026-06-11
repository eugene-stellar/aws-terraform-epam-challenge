# Lab 01: Creating Network Resources

## 📋 Objective
Construct a foundational AWS network stack using Infrastructure as Code (IaC) principles. This infrastructure serves as an isolated cloud environment for downstream services.

## 🛠️ Infrastructure Components
* **VPC:** Custom isolated virtual network (`10.10.0.0/16`).
* **Public Subnets:** Three subnets deployed across separate Availability Zones (`eu-west-1a`, `eu-west-1b`, `eu-west-1c`) to ensure High Availability (HA).
* **Internet Gateway:** Attached to the VPC to enable outbound internet access.
* **Route Table:** Custom routing rules configured to forward external traffic through the Internet Gateway, associated with all public subnets.

## 📂 File Structure
* `main.tf` – AWS provider configuration.
* `vpc.tf` – Network resources (VPC, Subnets, IGW, Route Table).
* `variables.tf` – Structured input variable declarations.
* `terraform.tfvars` – Non-sensitive environment configuration values.
* `versions.tf` – Lock constraints for Terraform and provider versions.
* `outputs.tf` – Exposed parameters (VPC ID, Subnet IDs).
