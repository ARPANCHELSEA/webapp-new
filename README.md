# DevOps Pipeline Project – Flask Web App

This project demonstrates a secure, observable, and maintainable DevOps pipeline built around a containerized Flask application. It uses real-world cloud-native tooling including Docker, Jenkins, Kubernetes (KinD), Helm, Trivy, and Prometheus.

---

## 📌 Objective

Design and implement a DevOps CI/CD pipeline to:
- Build and scan container images
- Push to a container registry
- Deploy to a Kubernetes cluster
- Integrate observability and security practices

---

## 🏗️ Architecture

![Project_architecture](https://github.com/user-attachments/assets/5b789b16-1a7d-437e-9ca2-6f880c62709a)


**Tools & Technologies:**
- **Flask** – Python web app with `/metrics` endpoints
- **Docker** – Multi-stage, non-root image builds
- **Jenkins** – CI/CD pipeline execution
- **Trivy** – Container vulnerability scanning
- **Helm** – Kubernetes manifests management
- **Kubernetes (KinD)** – Local cluster for deployment
- **Prometheus** – Metrics scraping via `/metrics` endpoint

GitHub Repo
   |
Jenkins (CI/CD)
   |
   ├── Build Docker Image
   ├── Scan with Trivy
   ├── Push to Docker Hub
   └── Deploy to Kubernetes (via Helm)
               |
               └── Flask App
                       └── Exposes `/metrics`



How to Run the Project (Step-by-Step)
1. Clone the Repository
git clone https://github.com/ARPANCHELSEA/webapp-new.git
cd webapp-new

2. Set Up Kubernetes (KinD)
kind create cluster --name dev-cluster
kubectl cluster-info

3. Install Jenkins
Use Docker or Helm to install Jenkins. Required plugins:
Docker
Trivy plugin
Kubernetes CLI plugin
Git

  In Jenkins:
Create a new pipeline project
Configure SCM to point to this repo
Use the Jenkinsfile in the repo
Create Jenkins credentials:
ID: docker-hub-creds
Type: Username/Password for Docker Hub

4. Configure Docker Registry
Update Dockerfile and Jenkinsfile with your Docker Hub username:
docker build -t <dockerhub-username>/webapp-new:latest .
docker push <dockerhub-username>/webapp-new:latest

5. Run the Jenkins Pipeline
On pushing code to main, Jenkins will:
Build the Docker image
Run Trivy vulnerability scan
Push the image to Docker Hub
Deploy to Kubernetes using Helm

6. Deploy to Kubernetes via Helm
helm install webapp helm-chart/

Check deployment:
kubectl get all
kubectl get ingress

7. Access the Application
Set up port forwarding or use Ingress:
kubectl port-forward svc/webapp 5000:5000
Home Page: http://localhost:5000/
Metrics: http://localhost:5000/metrics

8. Observability – Prometheus
Install Prometheus:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus


Secrets Management
Secrets (e.g., database passwords, API keys) are stored using Kubernetes Secrets and applied via Helm templates.

To view a secret:
kubectl get secret <name> -o yaml

Security
Dockerfile uses multi-stage builds
Runs with a non-root user
Uses Trivy for vulnerability scanning
No hardcoded credentials

Run Trivy manually:
trivy image <dockerhub-username>/webapp-new:latest


📦 Repository Structure
.
├── app/                   # Flask source code
├── Dockerfile             # Multi-stage, secure build
├── Jenkinsfile            # Jenkins CI/CD pipeline
├── helm-chart/            # Kubernetes deployment via Helm
├── k8s-secrets/           # Kubernetes Secrets (YAML)
└── README.md              # Project documentation


⚠️ Known Limitations
1. Due to environment constraints, a full end-to-end execution of the Jenkins pipeline has not been verified.
2. Also due to time constraints could not configure many things like Loki ( for log forwarding)
3. Being honest,many of the EKS service was paid so could not afford to run it also.

✅ Improvements
1. Automate Jenkins setup via scripts or Docker
2. Add log aggregation (e.g., Loki or ELK)
3. Add Grafana dashboards on top of Prometheus.


