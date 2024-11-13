#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Enable debug mode (optional, comment out if not needed)
set -x

# Get the absolute path to the script's directory
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Set up paths relative to the script directory
TEMP_DIR="$SCRIPT_DIR/temp_repos"
DOCS_SOURCE="$SCRIPT_DIR/source"
DOCS_BUILD="$SCRIPT_DIR/build/html"

# Increase Git buffer size to prevent clone errors on large repositories
git config --global http.postBuffer 524288000

# Create necessary directories
mkdir -p "$TEMP_DIR"
mkdir -p "$DOCS_SOURCE/libs"

# Clone the libraries
echo "Cloning libraries..."
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing.git "$TEMP_DIR/file-processing"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-ocr.git "$TEMP_DIR/file-processing-ocr"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-transcription.git "$TEMP_DIR/file-processing-transcription"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-analytics.git "$TEMP_DIR/file-processing-analytics"
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-test-data.git "$TEMP_DIR/file-processing-test-data"

# Generate API documentation for each library
echo "Generating API documentation..."

# Function to generate documentation for a library
generate_docs() {
    LIB_NAME=$1
    SOURCE_DIR="$TEMP_DIR/$LIB_NAME"
    OUTPUT_DIR="$DOCS_SOURCE/libs/$LIB_NAME"

    echo "Generating docs for $LIB_NAME..."

    # Create output directory
    mkdir -p "$OUTPUT_DIR"

    # Use positional arguments for exclude patterns
    sphinx-apidoc -o "$OUTPUT_DIR" "$SOURCE_DIR" "setup.py" "tests/*" "*/tests/*" --force

    # Check if sphinx-apidoc succeeded
    if [ $? -ne 0 ]; then
        echo "Error: sphinx-apidoc failed for $LIB_NAME"
        exit 1
    fi
}

# Generate docs for each library
generate_docs "file-processing"
generate_docs "file-processing-ocr"
generate_docs "file-processing-transcription"
generate_docs "file-processing-analytics"
generate_docs "file-processing-test-data"

# Build the documentation using Sphinx
echo "Building documentation..."
python -m sphinx -b html "$DOCS_SOURCE" "$DOCS_BUILD"

# Check if sphinx build succeeded
if [ $? -ne 0 ]; then
    echo "Error: Sphinx build failed"
    exit 1
fi

# Clean up the temporary directory
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

echo "Documentation build completed successfully!"
