# Particle41 DevOps Challenge

This repository contains my solution for the Particle41 DevOps Team Challenge.

It includes:

* **Task 1:** SimpleTimeService application, Docker image, and Kubernetes manifest
* **Task 2:** Terraform code to provision an AWS VPC and EKS cluster

---

## Repository Structure

```text id="l2b9t1"
.
├── app/
│   ├── index.js
│   ├── package.json
│   ├── Dockerfile
│   └── microservice.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── versions.tf
│   ├── terraform.tfvars.example
│   └── modules/
│       └── eks-cluster/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
└── .github/workflows/
```

---

## Prerequisites

Install the following tools before running this project:

* Node.js
* Docker
* kubectl
* Terraform
* AWS CLI

---

# Task 1 – SimpleTimeService

## Run locally

```bash id="tyhq7t"
cd app
npm install
node index.js
```

Test:

```bash id="8f6yx7"
curl http://localhost:8080
```

Expected response:

```json id="3srnfc"
{
  "timestamp": "2026-04-07T12:34:56.000Z",
  "ip": "127.0.0.1"
}
```

---

## Build and run with Docker

### Build image

```bash id="h9hwl9"
cd app
docker build -t simpletimeservice:latest .
```

### Run container

```bash id="s2knkx"
docker run -p 8080:8080 simpletimeservice:latest
```

### Test

```bash id="w55x7y"
curl http://localhost:8080
```

---

## Public Docker Image

The application image is published to Docker Hub:

```text id="09n1jv"
surentanwar7/simpletimeservice:latest
```

---

## Deploy to Kubernetes

### Deploy manifest

```bash id="b5n13r"
kubectl apply -f app/microservice.yml
```

### Verify resources

```bash id="7l5j2u"
kubectl get pods
kubectl get svc
```

### Test locally with port-forward

```bash id="wx7bhy"
kubectl port-forward svc/simpletimeservice 8080:80
```

Then in another terminal:

```bash id="hhrycb"
curl http://localhost:8080
```

---

# Task 2 – Terraform: AWS VPC + EKS

## AWS Authentication

AWS credentials are **not committed** to this repository.

Authenticate locally using the AWS CLI:

```bash id="nr9brn"
aws configure
```

Or export credentials as environment variables:

```bash id="g1jz1q"
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
export AWS_DEFAULT_REGION=us-east-1
```

---

## Deploy Infrastructure

```bash id="jlwmfy"
cd terraform

cp terraform.tfvars.example terraform.tfvars

terraform init
terraform plan
terraform apply
```

This provisions:

* 1 VPC
* 2 public subnets
* 2 private subnets
* 1 EKS cluster
* 1 managed node group
* 2 worker nodes (`m6a.large`) in private subnets

---

## Configure kubectl for EKS

After Terraform apply completes:

```bash id="b3pr7s"
aws eks update-kubeconfig --region us-east-1 --name particle41-eks
```

Verify:

```bash id="5f1s7m"
kubectl get nodes
```

---

## Deploy the application to EKS

```bash id="p4o6hr"
kubectl apply -f app/microservice.yml
```

Verify:

```bash id="mu4mnj"
kubectl get pods
kubectl get svc
```

Test with port-forward:

```bash id="v4l8n5"
kubectl port-forward svc/simpletimeservice 8080:80
curl http://localhost:8080
```

---

## Cleanup

To destroy AWS infrastructure and avoid charges:

```bash id="85zbdj"
cd terraform
terraform destroy
```

---

## Notes

* The Docker container runs as a **non-root user**
* The Kubernetes Service uses **ClusterIP** (not LoadBalancer)
* No credentials or secrets are committed to this repository
* GitHub Actions workflows are included for:

  * Docker image build/push
  * Terraform validation
