# devops-end-projectDevOps Project
Overview

This project demonstrates a complete DevOps workflow that deploys a Flask-based AWS monitoring application using modern automation tools.
It integrates Docker, Helm, Kubernetes, and Jenkins to simulate a real production CI/CD pipeline.
The goal is to show how to automate building, testing, and deploying an application to a Kubernetes cluster.

Project Structure
flask-aws-monitor/
├── Dockerfile
├── requirements.txt
├── main.py
├── Jenkinsfile
├── values.yaml
├── charts/
│   ├── Chart.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── ingress.yaml
│       └── _helpers.tpl

Technologies Used
Tool	Purpose
Python / Flask	Backend web application framework
Docker	Containerization of the Flask application
Helm	Kubernetes package management and templating
Kubernetes	Container orchestration
Jenkins	Continuous Integration and Continuous Deployment (CI/CD)
Prometheus (optional)	Application monitoring and metric collection
Docker
Build the Image
docker build -t your-dockerhub-username/flask-aws-monitor:latest .

Run the Container Locally
docker run -d -p 5001:5001 your-dockerhub-username/flask-aws-monitor


This runs the Flask app locally on port 5001.

Helm Deployment
Install the Chart
helm install flask-monitor ./flask-aws-monitor

Upgrade the Release
helm upgrade flask-monitor ./flask-aws-monitor

Uninstall the Release
helm uninstall flask-monitor

Check Kubernetes Resources
kubectl get pods
kubectl get svc
kubectl get deployments

Jenkins CI/CD Pipeline
Pipeline Stages

Clone Repository – Pulls the latest source code from GitHub.

Linting and Security Scan – Ensures code and image quality.

Build Docker Image – Builds the application image using the Dockerfile.

Push to Docker Hub – Uploads the image using Jenkins credentials.

Deploy to Kubernetes – Uses Helm to deploy the updated image to the cluster.

Jenkins Credentials

The pipeline expects the following credentials to be configured in Jenkins:

dockerhub-username

dockerhub-password

These are used to authenticate when pushing to Docker Hub.

Environment Variables

Defined in values.yaml and injected into the container:

env:
  - name: AWS_ACCESS_KEY_ID
    value: "test"
  - name: AWS_SECRET_ACCESS_KEY
    value: "test"
  - name: AWS_REGION
    value: "us-east-1"
  - name: AWS_DEFAULT_REGION
    value: "us-east-1"


Note: In production, these values should be stored in Kubernetes Secrets instead of plaintext.

Health Probes

Health checks are defined in values.yaml to ensure the application is running correctly:

Liveness Probe – Periodically checks the / endpoint to verify that the container is alive.

Readiness Probe – Ensures the application is ready to receive traffic before exposing it via the service.

Monitoring (Optional)

If Prometheus is installed in your cluster, a ServiceMonitor resource can be added to scrape metrics from the Flask app’s /metrics endpoint.

Key Concepts

Dockerfile: Defines how the Flask app is packaged into a container.

Helm Chart: Automates Kubernetes deployments and supports templating for different environments.

Jenkinsfile: Describes the CI/CD stages for building, testing, and deploying the app.

Values.yaml: Central configuration file for customizing Helm deployments.

Cleanup

To remove all related Kubernetes resources:

helm uninstall flask-monitor
kubectl delete all -l app.kubernetes.io/name=flask-aws-monitor

Summary

This project provides a modular example of how DevOps practices integrate across containerization, automation, and orchestration tools.
It showcases a real-world workflow where a simple Flask application is continuously built, tested, and deployed using Docker, Jenkins, and Helm on Kubernetes.
