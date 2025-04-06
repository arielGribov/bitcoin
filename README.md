

```markdown
# 📈 Bitcoin Price Tracker on GKE

This project is a cloud-native application that displays real-time Bitcoin prices using a Python backend and frontend, deployed to Google Kubernetes Engine (GKE). The infrastructure is managed using Terraform and the application is containerized with Docker.

---

## 📦 Project Structure


├── backend/            # Python FastAPI backend (not publicly accessible)
├── frontend/           # Frontend (publicly accessible)
├── terraform/          # Infrastructure as Code
│   ├── kubernetes/     # Kubernetes manifests for backend & frontend
│   └── main.tf         # GCP + GKE Terraform config


---

## 🚀 Deployment Guide

### 1. Set Up Infrastructure with Terraform

Make sure you have authenticated with Google Cloud CLI and configured your project.

bash:
cd terraform
terraform init
terraform apply


This will:
- Create a GKE cluster
- Set up networking
- Output GKE credentials (you can use them with `kubectl`)

---

### 2. Build & Push Docker Images

Replace `YOUR-PROJECT-ID` with your actual Google Cloud project ID.

#### 🔧 Backend

bash
docker build --platform linux/x86_64 --no-cache -t backend:latest ./backend
docker tag backend gcr.io/YOUR-PROJECT-ID/backend:latest
docker push gcr.io/YOUR-PROJECT-ID/backend:latest


#### 🎨 Frontend

bash
docker build --platform linux/x86_64 --no-cache -t frontend:latest ./frontend
docker tag frontend gcr.io/YOUR-PROJECT-ID/frontend:latest
docker push gcr.io/YOUR-PROJECT-ID/frontend:latest


---

### 3. Deploy to Kubernetes

Apply Kubernetes manifests to deploy the services to GKE:

bash
kubectl apply -f terraform/kubernetes/backend.yaml
kubectl apply -f terraform/kubernetes/frontend.yaml


---

### 4. Access the Frontend

Once deployed, get the external IP of the frontend service:

bash
kubectl get svc


Then open it in your browser to view the live Bitcoin price dashboard.

---

## 🧼 Notes

- The **backend** service is not exposed to the public
- The **frontend** service is accessible via a public IP

---

## 📄 License

MIT
```

---
