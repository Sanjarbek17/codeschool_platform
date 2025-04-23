#!/bin/bash

# Define source and destination directories
SOURCE_DIR="$(pwd)/build/web"
DEST_DIR="/Users/sanjarbeksaidov/backend/codeschool_backend/flutter_web/static"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

# Create the destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
  mkdir -p "$DEST_DIR"
fi

# Copy the web folder to the destination directory
cp -r "$SOURCE_DIR"/* "$DEST_DIR"/

# Print success message
echo "Flutter web build copied to $DEST_DIR"