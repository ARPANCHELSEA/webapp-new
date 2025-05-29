# DevOps Pipeline Project

This project includes a secure, observable CI/CD pipeline using Jenkins, Terraform, KinD, Helm, Prometheus, and Flask.

## Steps to Run

1. Provision KinD Cluster:
   ```bash
   cd terraform
   terraform init && terraform apply
   ```

2. Build Jenkins Pipeline:
   - Install Jenkins, Docker, Trivy plugins
   - Create credentials `docker-hub-creds` in Jenkins
   - Connect Jenkins to this repo with Jenkinsfile

3. Push to main branch to trigger build:
   ```bash
   git add .
   git commit -m "Initial pipeline setup"
   git push origin main
   ```

4. Access the app at:
   - `http://localhost/`
   - Prometheus metrics at `http://localhost/metrics`