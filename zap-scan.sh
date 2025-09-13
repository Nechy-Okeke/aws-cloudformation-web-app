#!/bin/bash

# --- Configuration ---
APP_IMAGE_NAME="my-devsecops-app"
ZAP_TARGET_IMAGE_NAME="my-devsecops-app"
APP_PORT=8081
APP_HOST="app-container"   # works with custom Docker network

# --- Workflow ---
echo "--- Starting DevSecOps Workflow: OWASP ZAP Scan ---"

# Pre-cleanup
echo "Performing pre-cleanup..."
docker stop ${APP_HOST} > /dev/null 2>&1 || true
docker network rm zapnet > /dev/null 2>&1 || true

# Create a user-defined network (so ZAP can talk to app by container name)
docker network create zapnet

# Step 1: Build the Docker image for your application
echo "Building the application image..."
docker build -t ${APP_IMAGE_NAME} ./app

if [ $? -ne 0 ]; then
  echo "❌ ERROR: Docker image build failed. Exiting."
  exit 1
fi

# Step 2: Start the application container
echo "Starting the application container for scanning..."
docker run -d --rm \
  --network zapnet \
  --name ${APP_HOST} \
  -p ${APP_PORT}:${APP_PORT} \
  ${ZAP_TARGET_IMAGE_NAME}

if [ $? -ne 0 ]; then
  echo "❌ ERROR: Failed to start the application container. Exiting."
  docker logs ${APP_HOST}
  exit 1
fi

# Wait for the app to come online
echo "Waiting for the application to become available..."
sleep 5

# Step 3: Run the OWASP ZAP baseline scan
echo "Starting OWASP ZAP baseline scan..."
mkdir -p zap-reports

# Always ensure latest ZAP image is pulled
docker pull ghcr.io/zaproxy/zaproxy:stable

docker run --rm \
  --network zapnet \
  -v "$(pwd)/zap-reports:/zap/wrk:rw" \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py \
  -t http://${APP_HOST}:${APP_PORT} \
  -r zap_baseline_report.html

# Step 4: Cleanup
echo "Cleaning up..."
docker stop ${APP_HOST} > /dev/null 2>&1 || true
docker network rm zapnet > /dev/null 2>&1 || true

echo "✅ DevSecOps Workflow Complete."
echo "📄 Scan report saved to zap-reports/zap_baseline_report.html"
