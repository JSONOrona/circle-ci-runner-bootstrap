#!/bin/bash

# Function to display help message
show_help() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  -o <organization>        Specify the CircleCI organization."
  echo "  -r <resource class>      Specify the CircleCI runner resource class."
  echo "  -t <runner token>        Specify the CircleCI runner token."
  echo "  -u                        Uninstall the CircleCI runner."
  echo "  -h                       Display this help message and exit."
  echo ""
  echo "Example:"
  echo "  $0 -o my-org -r my-resource-class -t my-runner-token"
  echo "  $0 -u (to uninstall the CircleCI runner)"
}

# Cleanup function
cleanup() {
  echo "Cleaning up temporary files..."
  # Add commands to clean up any temporary files or configurations created by the script
}

# Uninstall function
uninstall_runner() {
  echo "Uninstalling CircleCI runner..."
  # Add commands to stop the CircleCI runner service and remove any related files or configurations
  sudo systemctl stop circleci-runner
  sudo systemctl disable circleci-runner
  sudo rm -f /usr/local/bin/circleci-launch-agent
  sudo rm -f /etc/systemd/system/circleci-runner.service
  sudo rm -rf /etc/circleci
  sudo systemctl daemon-reload
  echo "CircleCI runner has been uninstalled."
}

# Initialize our variables
CIRCLECI_ORG=""
CIRCLECI_RESOURCE_CLASS=""
CIRCLECI_RUNNER_TOKEN=""
UNINSTALL=0

# Parse command-line options
while getopts 'o:r:t:uh' flag; do
  case "${flag}" in
    o) CIRCLECI_ORG="${OPTARG}" ;;
    r) CIRCLECI_RESOURCE_CLASS="${OPTARG}" ;;
    t) CIRCLECI_RUNNER_TOKEN="${OPTARG}" ;;
    u) UNINSTALL=1 ;;
    h) show_help
       exit 0 ;;
    *) show_help
       exit 1 ;;
  esac
done

if [ "${UNINSTALL}" -eq 1 ]; then
  uninstall_runner
  exit 0
fi

# Check for mandatory options
if [ -z "${CIRCLECI_ORG}" ] || [ -z "${CIRCLECI_RESOURCE_CLASS}" ] || [ -z "${CIRCLECI_RUNNER_TOKEN}" ]; then
  echo "Error: Missing required arguments for installation."
  show_help
  exit 1
fi

# Proceed with the rest of the script for installation...
sudo apt-get update && sudo apt-get install -y curl

curl -LJO "https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent/release/latest/linux/amd64/circleci-launch-agent"
chmod +x circleci-launch-agent
sudo mv circleci-launch-agent /usr/local/bin

# Your existing script logic here for configuring and starting the runner

# Perform cleanup after successful installation
cleanup

echo "CircleCI runner installation and configuration complete."
