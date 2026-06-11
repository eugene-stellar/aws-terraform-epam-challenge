# Lab 09: Use Data Discovery

## 📋 Objective
Eliminate rigid cross-project file linkages by implementing dynamic runtime asset discovery using flexible tag filtering, decoupling infrastructure provisioning from explicit backend variables.

## 🛠️ Infrastructure Components
* **Dynamic Data Filtering:** Dynamic querying of pre-existing AWS target modules (VPCs, Subnets, and Security Groups) based entirely on metadata signatures (`tag:Name`).
* **AMI Regex Matching:** Automated matching patterns capturing the newest available x86_64 Amazon Linux 2023 OS image versions.

## 📂 File Structure
* `main.tf` – Targeted runtime provider definitions.
* `data.tf` – Tag-filtered queries executing data collection lookups across live cloud services.
* `compute.tf` – Immutable EC2 definitions consuming parameters delivered by runtime discoveries.
* `variables.tf` – Declarative metadata name schema maps.
* `terraform.tfvars` – Baseline environment parameter values.
* `versions.tf` – Execution engine locking definitions.
* `outputs.tf` – Discovered compute telemetry fields.
