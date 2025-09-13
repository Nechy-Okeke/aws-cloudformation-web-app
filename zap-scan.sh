#!/bin/bash

# Check if the target URL is provided
if [ -z "$1" ]; then
  echo "Error: Target URL not provided."
  echo "Usage: ./zap-scan.sh <target_url>"
  exit 1
fi

TARGET_URL=$1
ZAP_PATH="/zap/zap.sh"

echo "Starting ZAP scan for target: $TARGET_URL"

# The ZAP container entrypoint runs the scan,
# so we can use a simple Docker command.
docker run -v $(pwd):/zap/wrk/:rw \
  -t owasp/zap2docker-stable zap-full-scan.py \
  -t $TARGET_URL \
  -r zap_report.html \
  -J zap_report.json \
  -x zap_report.xml

echo "ZAP scan finished. Reports generated in the current directory."
