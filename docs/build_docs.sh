#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Get the absolute path to the 'docs' directory
DOCS_DIR=$(cd "$(dirname "$0")" && pwd)

# Set up paths relative to the 'docs' directory
TEMP_DIR="$DOCS_DIR/temp_repos"
DOCS_SOURCE="$DOCS_DIR/source"
DOCS_BUILD="$DOCS_DIR/build/html"
LIBS_SOURCE="$DOCS_SOURCE/libs"

# Clean up previous build and temp directories
echo "Cleaning previous build..."
rm -rf "$DOCS_BUILD" "$TEMP_DIR" "$LIBS_SOURCE"

# Create necessary directories
mkdir -p "$TEMP_DIR" "$DOCS_BUILD" "$LIBS_SOURCE"

# List of repositories to clone and document
declare -A REPOSITORIES=(
    ["file-processing"]="https://github.com/hc-sc-ocdo-bdpd/file-processing.git"
    ["file-processing-ocr"]="https://github.com/hc-sc-ocdo-bdpd/file-processing-ocr.git"
    ["file-processing-transcription"]="https://github.com/hc-sc-ocdo-bdpd/file-processing-transcription.git"
    ["file-processing-analytics"]="https://github.com/hc-sc-ocdo-bdpd/file-processing-analytics.git"
    ["file-processing-test-data"]="https://github.com/hc-sc-ocdo-bdpd/file-processing-test-data.git"
)

# Clone the repositories
echo "Cloning repositories..."
for LIB_NAME in "${!REPOSITORIES[@]}"; do
    REPO_URL="${REPOSITORIES[$LIB_NAME]}"
    git clone --depth 1 "$REPO_URL" "$TEMP_DIR/$LIB_NAME"
done

# Function to generate API documentation for a library
generate_docs() {
    local LIB_NAME=$1
    local SOURCE_DIR="$TEMP_DIR/$LIB_NAME"
    local OUTPUT_DIR="$LIBS_SOURCE/$LIB_NAME"

    echo "Generating docs for $LIB_NAME..."

    # Create output directory
    mkdir -p "$OUTPUT_DIR"

    # Generate API docs, excluding certain files and directories
    sphinx-apidoc -o "$OUTPUT_DIR" "$SOURCE_DIR" "setup.py" "tests/*" "*/tests/*" "**/tests/*" --force

    if [ $? -ne 0 ]; then
        echo "Error: sphinx-apidoc failed for $LIB_NAME"
        exit 1
    fi
}

# Generate API documentation for each library
for LIB_NAME in "${!REPOSITORIES[@]}"; do
    generate_docs "$LIB_NAME"
done

# Build the documentation using Sphinx
echo "Building HTML documentation with Sphinx..."
python -m sphinx -b html "$DOCS_SOURCE" "$DOCS_BUILD"

# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Documentation build completed successfully!"
