#!/bin/bash

# Define source and destination directories
SOURCE_DIR="$(pwd)/build/web"
DEST_DIR="/Users/sanjarbeksaidov/backend/codeschool_backend/flutter_web/"

# Check Flutter version
FLUTTER_VERSION=$(flutter --version 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "Flutter is not installed or not in PATH. Please install Flutter and try again."
  exit 1
fi

# Print Flutter version
echo "Using Flutter version: $FLUTTER_VERSION"

# Build the Flutter web project with specified options
flutter build web --base-href "/flutter_web/" --output="$DEST_DIR"

# Print success message
echo "Flutter web build completed and output is in $DEST_DIR"