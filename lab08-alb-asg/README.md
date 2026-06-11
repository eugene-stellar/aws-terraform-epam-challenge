# Lab 08: Application Instances behind a Load Balancer

## 📋 Objective
Engineer a self-healing, highly scalable multi-AZ architecture by integrating an Application Load Balancer with an Auto Scaling Group utilizing IMDSv2 user-data telemetry tracking.

## 🛠️ Infrastructure Components
* **AWS Launch Template:** Standardized compute blueprint with mandatory IMDSv2 metadata constraints and dynamic automated web server installations.
* **Auto Scaling Group:** Maintains an active server cluster across public subnets with integrated ignore lifecycles.
* **Application Load Balancer:** Front-facing reverse proxy with attached HTTP listeners routing internet traffic safely across auto-healing targets.

## 📂 File Structure
* `main.tf` – Cloud provider initialization.
* `application.tf` – Integrated blueprints for templates, load balancers, scale rings, listeners, and target bindings.
* `variables.tf` – Structuring inputs mapping pre-existing subnets and security perimeters.
* `terraform.tfvars` – Target baseline names and parameter declarations.
* `versions.tf` – Semantic lock boundaries for required extensions.
* `outputs.tf` – Active load balancer DNS links and target arrays.
