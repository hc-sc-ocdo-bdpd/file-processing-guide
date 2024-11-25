#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Enable debug mode (optional, comment out if not needed)
set -x

# Get the absolute path to the script's directory
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
REPO_ROOT="$SCRIPT_DIR/.."  # Adjust this if your script is not in a subdirectory

# Set up paths relative to the script directory
TEMP_DIR="$SCRIPT_DIR/temp_repos"
DOCS_SOURCE="$SCRIPT_DIR/source"
DOCS_BUILD="$SCRIPT_DIR/build/html"
DOCS_DEPLOY="$REPO_ROOT/docs"  # Deploy to /docs directory at the root of your repository

# Increase Git buffer size to prevent clone errors on large repositories
git config --global http.postBuffer 524288000

# Clean up previous build and temp directory
echo "Cleaning previous build..."
rm -rf "$DOCS_BUILD" "$TEMP_DIR" "$DOCS_DEPLOY"

# Create necessary directories
mkdir -p "$TEMP_DIR" "$DOCS_BUILD" "$DOCS_SOURCE/libs" "$DOCS_DEPLOY"

# Clone the libraries
echo "Cloning libraries..."
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing.git "$TEMP_DIR/file-processing"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-ocr.git "$TEMP_DIR/file-processing-ocr"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-transcription.git "$TEMP_DIR/file-processing-transcription"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-analytics.git "$TEMP_DIR/file-processing-analytics"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-test-data.git "$TEMP_DIR/file-processing-test-data"

# Function to generate API documentation for a library
generate_docs() {
    LIB_NAME=$1
    SOURCE_DIR="$TEMP_DIR/$LIB_NAME"
    OUTPUT_DIR="$DOCS_SOURCE/libs/$LIB_NAME"

    echo "Generating docs for $LIB_NAME..."

    # Create output directory
    mkdir -p "$OUTPUT_DIR"

    # Generate API docs, excluding setup.py and test directories
    sphinx-apidoc -o "$OUTPUT_DIR" "$SOURCE_DIR" "setup.py" "tests/*" "*/tests/*" "**/tests/*" --force

    # Check if sphinx-apidoc succeeded
    if [ $? -ne 0 ]; then
        echo "Error: sphinx-apidoc failed for $LIB_NAME"
        exit 1
    fi
}

# Generate API documentation for each library
generate_docs "file-processing"
generate_docs "file-processing-ocr"
generate_docs "file-processing-transcription"
generate_docs "file-processing-analytics"
generate_docs "file-processing-test-data"

# Build the documentation using Sphinx
echo "Building HTML documentation with Sphinx..."
python -m sphinx -b html "$DOCS_SOURCE" "$DOCS_BUILD"

# Deploy build artifacts to the /docs directory
echo "Deploying built HTML files to /docs..."
cp -r "$DOCS_BUILD"/* "$DOCS_DEPLOY/"

# Clean up temporary files
echo "Cleaning up..."
rm -rf "$TEMP_DIR" "$DOCS_BUILD" "$DOCS_SOURCE/libs"

echo "Documentation build and deployment completed successfully!"
