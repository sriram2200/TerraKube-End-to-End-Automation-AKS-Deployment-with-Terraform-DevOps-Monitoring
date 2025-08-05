# TerraKube-End-to-End-Automation-AKS-Deployment-with-Terraform-DevOps-Monitoring
## 📌 Project Overview

**TerraKube** is a fully automated, production-style DevOps pipeline that provisions infrastructure and deploys a Dockerized Python application to **Azure Kubernetes Service (AKS)** using **Terraform** and **Azure DevOps**.

This project simulates a real-world DevOps workflow with complete automation — including infrastructure provisioning, CI/CD, Kubernetes deployment, ingress exposure, and cluster monitoring using **Prometheus** and **Grafana**. No resources are manually created in the Azure portal.

##  Infrastructure Setup (Terraform)

###  Stage 1: Bootstrap
- Creates:
  - Azure Resource Group
  - Storage Account & Blob Container (for Terraform remote state)
- Assigns roles to Service Principal:
  - **Contributor** for Resource Group
  - **Blob Data Contributor** for Storage Account

```bash
cd infra/bootstrap
terraform init -backend=false
terraform apply
```

### Stage 2: Main Infrastructure
- Deploys:
  - Azure Kubernetes Service (AKS)
  - Azure Container Registry (ACR)
  - VNet with Subnet
  - ACR Pull Role Assignment for AKS
  - Uses remote backend from Stage 1

```bash
cd infra/main
terraform init
terraform apply
```
###  Stage 3: Monitoring and Expose 
- Deploys:
  - NGINX Ingress Controller deployed via Helm
  - Prometheus and Grafana via Helm

###  Application CI/CD (Azure DevOps)
- Pipeline: Infra Deployment
   - Stage 1: Run bootstrap Terraform (no backend)
   - Stage 2: Deploy AKS, ACR, VNet using remote backend

- Pipeline: App Deployment
  - Stage 1: Build Docker image from Python app → Push to ACR
  - Stage 2: Generate K8s manifests → Deploy to AKS with Ingress exposure via NGINX Controller
 
## Ingress Setup
   - NGINX Ingress Controller deployed via Helm
   - LoadBalancer service created to expose Ingress Controller
   - Ingress resource defined for Python app routing
   - External traffic flows via LoadBalancer → Ingress → Service → Pods

## Monitoring Stack
   - Deployed via aks-monitoring Terraform module
   - Tools:
     - Prometheus: Metrics scraping from AKS
     - Grafana: Visualization dashboards
  - Pipeline-triggered deployment, fully automated

### Architecture Diagram

![Architecture Diagram](https://github.com/user-attachments/assets/69f58226-d4b2-4581-8123-fa0ab39fa033)

## 🙋‍♂️ Author

**Sasi Sriram**  
📧 [sasisriram162005@gmail.com](mailto:sasisriram162005@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/sasisriram)  
🔗 [GitHub](https://github.com/sriram2200)

