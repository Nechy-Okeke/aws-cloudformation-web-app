#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# The target URL to scan is passed as the first argument to the script.
TARGET_URL=$1
echo "Starting ZAP scan against target: $TARGET_URL"

# The official ZAP Docker image from the GitHub Container Registry.
# This image is the replacement for the deprecated owasp/zap2docker-stable image.
ZAP_DOCKER_IMAGE="ghcr.io/zaproxy/zaproxy"

# Check if a custom rules file exists in the repository.
RULES_FILE="zap_rules.txt"
if [ -f "$RULES_FILE" ]; then
    echo "Found custom rules file. Using it for the scan."
    RULES_FLAG="-config rule.rules.file=/zap/wrk/$RULES_FILE"
else
    echo "No custom rules file found. Using default rules."
    RULES_FLAG=""
fi

# Run the ZAP full scan using the Docker image.
docker run \
  -v "$(pwd):/zap/wrk/:rw" \
  ${ZAP_DOCKER_IMAGE} zap-baseline.py \
  -t "$TARGET_URL" \
  -J zap_report.json \
  -r zap_report.html \
  -x zap_report.xml \
  -z "-config api.access.url.list.url=$TARGET_URL" \
  $RULES_FLAG

echo "ZAP scan complete. Reports are available in the repository."
