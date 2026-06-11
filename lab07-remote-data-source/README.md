# Lab 07: Configure a Remote Data Source

## 📋 Objective
Establish cross-cutting architecture synchronization by utilizing the `terraform_remote_state` construct to safely retrieve baseline Landing Zone assets out of a decoupled Amazon S3 state repository.

## 🛠️ Infrastructure Components
* **Remote State Discovery:** Decoupled reading pipelines accessing an upstream readonly S3 backend cluster (`infra.tfstate`).
* **Dynamically provisioned Compute:** Public EC2 instances referencing network variables entirely through the discovered remote output tree.

## 📂 File Structure
* `main.tf` – Execution provider schemas.
* `data.tf` – S3 remote state tracking blocks (`base_infra`) alongside dynamic AMI regex lookups.
* `compute.tf` – EC2 instances consuming variables passed by the remote baseline pipeline.
* `variables.tf` – Structuring maps tracking remote storage configuration pointers.
* `terraform.tfvars` – Remote state parameters and explicit tagging targets.
* `versions.tf` – Baseline core version requirements.
* `outputs.tf` – Dynamic compute identifiers.
