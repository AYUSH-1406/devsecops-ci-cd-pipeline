

# 🚀 DevSecOps CI/CD Pipeline with Jenkins, Docker, Trivy & AWS EKS

This project demonstrates an **end-to-end DevSecOps CI/CD pipeline** that automates build, security scanning, containerization, and deployment of a Java application to **AWS EKS** using **Jenkins and Helm**, following real-world DevSecOps best practices.

---

## 📌 Project Overview

The pipeline ensures that **security is embedded at every stage** of the software delivery lifecycle:

* Static code analysis (SAST)
* Dependency vulnerability scanning (SCA)
* Container image vulnerability scanning
* Secure Docker image delivery
* Automated deployment to Kubernetes (EKS)
* Helm-based versioned deployments with rollback support

---

## 🧱 Architecture Flow

```
Developer → GitHub → Jenkins CI/CD Pipeline
                 ↓
        Maven Build & Test
                 ↓
          SonarQube (SAST)
                 ↓
     OWASP Dependency-Check (SCA)
                 ↓
          Docker Image Build
                 ↓
         Trivy Image Scan
                 ↓
          Docker Hub Push
                 ↓
        Helm Deployment to AWS EKS
```

---

## 🛠️ Tech Stack

### CI/CD & DevOps

* Jenkins
* GitHub Webhooks
* Maven

### Security (DevSecOps)

* SonarQube (Static Code Analysis)
* OWASP Dependency-Check (Dependency Vulnerabilities)
* Trivy (Container Image Scanning)

### Containers & Orchestration

* Docker
* Kubernetes (AWS EKS)
* Helm

### Cloud

* AWS EKS
* AWS IAM
* AWS LoadBalancer Service

---

## 🔐 Security Controls Implemented

✔ **SAST** – SonarQube scans source code for bugs, vulnerabilities, and code smells
✔ **Quality Gates** – Pipeline fails if SonarQube quality gate fails
✔ **SCA** – OWASP Dependency-Check scans third-party libraries
✔ **Container Security** – Trivy scans Docker images for HIGH & CRITICAL CVEs
✔ **Fail-Fast Strategy** – Pipeline stops on any security violation

---

## ⚙️ Jenkins Pipeline Stages

1. **Checkout Source Code**
2. **Maven Build**
3. **SonarQube Analysis (SAST)**
4. **Quality Gate Enforcement**
5. **OWASP Dependency-Check (SCA)**
6. **Docker Image Build**
7. **Trivy Image Scan**
8. **Docker Image Push**
9. **Helm-based Deployment to AWS EKS**
10. **Rollback on Deployment Failure**
11. **Email Notifications**

---

## 🐳 Docker Image Strategy

* Each build is tagged with the **Jenkins build number**
* Avoids the `latest` tag anti-pattern
* Enables traceability and rollback

Example:

```
dockerhubusername/devsecops-app:42
```

---

## ☸️ Kubernetes Deployment (AWS EKS)

* Deployed using **Helm charts**
* LoadBalancer service exposes the application publicly
* Supports:

  * Helm upgrades
  * Version history
  * Rollbacks on failure

---

## 🚀 How to Access the Application

```bash
kubectl get svc
```

Open the `EXTERNAL-IP` in a browser:

```
http://<LOAD_BALANCER_EXTERNAL_IP>
```

---

## 🧪 Useful Commands

### Check Deployment

```bash
kubectl get pods
kubectl get svc
kubectl describe deployment devsecops
```

### Helm Operations

```bash
helm list
helm history devsecops
helm rollback devsecops <REVISION>
```

---

## 📂 Repository Structure

```
.
├── Jenkinsfile
├── Dockerfile
├── pom.xml
├── src/
├── k8s/                 # (optional raw manifests)
├── devsecops-chart/     # Helm chart
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
└── README.md
```

---

## 🎯 Key Learnings

* Built a **production-grade DevSecOps pipeline**
* Integrated security at every stage of CI/CD
* Implemented **automated Kubernetes deployments**
* Used Helm for **versioning, upgrades, and rollback**
* Followed real enterprise DevOps practices

---

## 🧠 Interview Talking Points

> “I implemented an end-to-end DevSecOps CI/CD pipeline using Jenkins that integrates SAST, SCA, and container security scanning, builds and pushes Docker images, and deploys to AWS EKS using Helm with automated rollbacks.”

---

## ⚠️ Cost Cleanup (Important)

To avoid AWS charges:

```bash
eksctl delete cluster --name devsecops-cluster --region ap-south-1
```

---

## 📌 Future Enhancements

* ALB Ingress + HTTPS (ACM)
* Canary / Blue-Green deployments
* Prometheus & Grafana monitoring
* Secrets management with IRSA
* GitOps using ArgoCD

---

## ⭐ Final Note

This project reflects **real-world DevSecOps implementation**, not a toy example.
Feel free to fork, extend, or use it as a reference for production pipelines.

---

If you want, next I can:

* Review your **actual Jenkinsfile** for polish
* Add **badges** (build, security, Docker pulls)
* Mock **DevSecOps interview questions** based on this project
