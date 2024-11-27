#!/bin/bash

# Function to log messages with timestamp
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}

# Check if the commit message is provided
if [ -z "$1" ]; then
  echo "Please provide a commit message."
  exit 1
fi

# Log the commit start
log_message "Starting commit process"

# Commit the changes with the provided message
git add .
git commit -m "$1"

# Log the successful commit
log_message "Committed with message: $1"

# Push the changes to the current branch (not to 'main')
git push origin $(git rev-parse --abbrev-ref HEAD)

# Log the successful push
log_message "Pushed changes to $(git rev-parse --abbrev-ref HEAD) branch"

# Publish to GitHub Pages using Quarto from the correct folder
quarto publish gh-pages --no-render --no-prompt --project-dir ./mi-practica-quarto

# Log the completion of the publishing process
log_message "Published to GitHub Pages"