## 🚀 Operationalizing a Coworking Space Service

### 📌 Project Overview
This project demonstrates the operationalization of a microservices-based coworking space analytics service on AWS using modern DevOps practices.  
The application exposes RESTful APIs that provide business analysts with insights into user activity and space utilization.

The primary focus of this project is building a **production-ready CI/CD pipeline**, deploying the service to **Kubernetes on Amazon EKS**, and enabling **monitoring and observability** using AWS CloudWatch.

---

### 🏗️ Architecture
The system follows a microservices architecture composed of the following components:

- **Analytics API** – Python Flask service exposing REST endpoints  
- **PostgreSQL Database** – Persistent data store for user activity and token data  
- **Amazon EKS** – Managed Kubernetes service for container orchestration  
- **Amazon ECR** – Private container registry for Docker images  
- **AWS CodeBuild** – CI pipeline for automated builds and pushes  
- **CloudWatch Container Insights** – Centralized logging and metrics collection  

---

### 🛠️ Technologies Used
- **Kubernetes** – Container orchestration  
- **Docker** – Application containerization  
- **Python (Flask)** – Analytics API framework  
- **PostgreSQL** – Relational database  
- **AWS Services** – EKS, ECR, CodeBuild, CloudWatch  
- **kubectl** – Kubernetes command-line tool  
- **eksctl** – EKS cluster lifecycle management  

---

### ⚙️ Deployment Process

#### 🔑 Prerequisites
- AWS CLI configured with appropriate IAM permissions  
- Docker installed locally  
- `kubectl` and `eksctl` installed  
- GitHub repository connected to AWS CodeBuild  

---

#### 1️⃣ Infrastructure Setup
Create an Amazon EKS cluster using `eksctl`:

```bash
eksctl create cluster \
  --name my-cluster \
  --region us-east-1 \
  --nodegroup-name my-nodes \
  --node-type t3.small \
  --nodes 1 \
  --nodes-min 1 \
  --nodes-max 2

Update kubeconfig to connect to the cluster:

aws eks --region us-east-1 update-kubeconfig --name my-cluster

2️⃣ Database Configuration

Deploy PostgreSQL with persistent storage:

kubectl apply -f deployment/pvc.yaml
kubectl apply -f deployment/pv.yaml
kubectl apply -f deployment/postgresql-deployment.yaml
kubectl apply -f deployment/postgresql-service.yaml


Database schemas and seed data are applied using port forwarding.

3️⃣ CI/CD Pipeline

A CI pipeline is implemented using AWS CodeBuild and triggers automatically on GitHub commits.

Pipeline stages:

Pre-build – Authenticate with Amazon ECR

Build – Build Docker image and tag using $CODEBUILD_BUILD_NUMBER

Post-build – Push versioned image to Amazon ECR

The workflow is defined in buildspec.yaml.

4️⃣ Application Deployment

Deploy the analytics application using Kubernetes manifests:

kubectl apply -f deployment/configmap.yaml
kubectl apply -f deployment/secret.yaml
kubectl apply -f deployment/coworking.yaml


Deployment includes:

ConfigMap for non-sensitive configuration

Secret for sensitive credentials

Deployment with resource limits and health probes

LoadBalancer Service to expose the API

5️⃣ Verification

Verify deployment status:

kubectl get pods
kubectl get svc
kubectl describe deployment coworking


Test API endpoints using the external LoadBalancer IP:

curl http://<EXTERNAL-IP>:5153/api/reports/daily_usage
curl http://<EXTERNAL-IP>:5153/api/reports/user_visits

6️⃣ Monitoring & Logging

AWS CloudWatch Container Insights is enabled to collect:

Application logs

Pod and container metrics

Health and performance indicators

Logs are available in the CloudWatch console under Container Insights.

🔄 Releasing New Builds

To deploy a new version of the application:

Commit and push code changes to GitHub

CodeBuild automatically builds and pushes a new Docker image to ECR

Update the image tag in deployment/coworking.yaml

Apply changes and monitor rollout:

kubectl apply -f deployment/coworking.yaml
kubectl rollout status deployment/coworking


Kubernetes performs a rolling update to ensure zero downtime.

📊 Resource Allocation

The deployment defines explicit CPU and memory limits:

resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"


These values ensure predictable performance and prevent over-provisioning.

💰 Cost Optimization Strategies

Use t3.small instances for development workloads

Enable Horizontal Pod Autoscaling

Use Spot Instances for non-production environments

Apply ECR lifecycle policies to remove unused images

Consider EKS Fargate for serverless container execution

📂 Project Structure
.
├── analytics/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── db/
│   └── *.sql
├── deployment/
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── coworking.yaml
│   ├── postgresql-deployment.yaml
│   ├── postgresql-service.yaml
│   ├── pv.yaml
│   └── pvc.yaml
├── buildspec.yaml
└── README.md

🧹 Cleanup

Remove all deployed resources to avoid ongoing charges:

kubectl delete -f deployment/
eksctl delete cluster --name my-cluster --region us-east-1

🧠 Project Summary

This project showcases enterprise-grade DevOps practices by containerizing a Python analytics API, automating builds with AWS CodeBuild, and deploying to Amazon EKS.
It implements CI/CD automation, Kubernetes configuration management, persistent storage, health checks, and centralized logging using CloudWatch Container Insights.
