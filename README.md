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
