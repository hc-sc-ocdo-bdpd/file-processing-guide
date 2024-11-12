#!/bin/bash

# Get the absolute path to the script's directory
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Set up paths relative to the script directory
TEMP_DIR="$SCRIPT_DIR/../temp_repos"
DOCS_SOURCE="$SCRIPT_DIR/source/libs"
DOCS_BUILD="$SCRIPT_DIR/_build/html"

# Increase Git buffer size to prevent clone errors on large repositories
git config --global http.postBuffer 524288000

# Create a temporary directory for cloned repositories
mkdir -p $TEMP_DIR

# Clone the libraries
echo "Cloning libraries..."
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing.git $TEMP_DIR/file-processing
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-ocr.git $TEMP_DIR/file-processing-ocr
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-transcription.git $TEMP_DIR/file-processing-transcription
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-analytics.git $TEMP_DIR/file-processing-analytics
git clone https://github.com/hc-sc-ocdo-bdpd/file-processing-test-data.git $TEMP_DIR/file-processing-test-data

# Generate API documentation for each library
echo "Generating API documentation..."
sphinx-apidoc -o $DOCS_SOURCE/file_processing $TEMP_DIR/file-processing --force
sphinx-apidoc -o $DOCS_SOURCE/file_processing_ocr $TEMP_DIR/file-processing-ocr --force
sphinx-apidoc -o $DOCS_SOURCE/file_processing_transcription $TEMP_DIR/file-processing-transcription --force
sphinx-apidoc -o $DOCS_SOURCE/file_processing_analytics $TEMP_DIR/file-processing-analytics --force
sphinx-apidoc -o $DOCS_SOURCE/file_processing_test_data $TEMP_DIR/file-processing-test-data --force

# Build the documentation using Python instead of make
echo "Building documentation..."
python -m sphinx -b html "$SCRIPT_DIR/source" "$SCRIPT_DIR/_build/html"

# Clean up the temporary directory
echo "Cleaning up..."
rm -rf $TEMP_DIR

echo "Documentation build completed successfully!"
