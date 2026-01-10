  
---

# Coworking Space Analytics \- K8S Deployment Guide

## 🏗 Architecture & CI/CD

The project uses AWS CodeBuild to automate the build process, pushing Docker images to Amazon ECR. The application is deployed on Kubernetes, utilizing a stateless Flask frontend and a persistent PostgreSQL backend.

## ⚠️ Challenges & "Tried Everything" Analysis

I encountered a deceptive "Running but 0/1 READY" state where the pod was active but failing its Readiness Probe. Despite verifying ECR image integrity and Service networking, I discovered a database "Auth Lock" where the internal Postgres engine ignores environment variable updates if a data volume already exists. I resolved this by manually exec-ing into the pod to run ALTER USER myuser WITH PASSWORD 'mypassword'; and standardizing the Python os.environ keys to match the ConfigMap exactly.

## 📊 Database Operations

Manual schema verification is performed using psql to execute queries directly against the analytics tables. To ensure the application picks up these backend changes, a kubectl rollout restart deployment coworking is used to refresh the stale connection pool.  
---

## 🟢 Standout Suggestions

Resource Allocation: We specify a request of 256Mi Memory / 250m CPU and a limit of 512Mi Memory / 500m CPU to prevent OOM kills. This ensures the Python analytics engine has enough overhead for spikes without consuming the entire node.  
Recommended AWS Instance: The t3.medium is the ideal instance type because it provides the 4GiB of RAM necessary to run the database and app concurrently. It offers a cost-effective burstable CPU profile that handles the periodic I/O of analytics processing.  
Cost Optimization: To save costs, we can utilize AWS Spot Instances for the application nodes to reduce compute pricing by up to 90%. Additionally, implementing KEDA to scale the coworking pods to zero during off-hours significantly reduces unnecessary resource consumption.

