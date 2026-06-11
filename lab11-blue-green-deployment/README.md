# Lab 11: Blue-Green Deployment with Traffic Routing

## 📋 Objective
Coordinate advanced zero-downtime micro-release deployment workflows by engineering weighted target group traffic distribution profiles managed entirely through code variables on an Application Load Balancer.

## 🛠️ Infrastructure Components
* **Dual Environment Footprints:** Independent launch blueprints and separate Auto Scaling Rings isolating **Blue** and **Green** application domains.
* **Weighted Load Balancing:** An ALB listener block equipped with fine-grained routing engines controlling percentage-based traffic splits via declarative variables (`blue_weight` / `green_weight`).

## 📂 File Structure
* `main.tf` – Provider definitions.
* `resources.tf` – Advanced ALB configurations, target pairs, scale rings, and weighted listener structures.
* `variables.tf` – Schema mapping data targets and numeric routing weights.
* `terraform.tfvars` – Real-world split configurations initialization inputs.
* `versions.tf` – Core tool lifecycle version locking parameters.
* `outputs.tf` – Frontline ALB endpoints for live release testing.
