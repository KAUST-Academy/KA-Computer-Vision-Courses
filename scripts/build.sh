#!/bin/bash
set -e

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default output directory is the current directory
OUTPUT_DIR="."
PDF_NAME="main.pdf"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --output)
      OUTPUT_DIR="$2"
      shift 2
      ;;
    --name)
      PDF_NAME="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Ensure the output directory exists
if [ "$OUTPUT_DIR" != "." ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Navigate to the source directory
cd "$PROJECT_ROOT/template" || { echo "Error: Could not find template directory"; exit 1; }

# Build the PDF
echo "Building PDF..."
# latexmk -f -pdf main.tex || echo "Warning: PDF build had issues but continuing..."
latexmk -pdf -interaction=nonstopmode -file-line-error -bibtex -use-make main.tex || echo "Warning: PDF build had issues but continuing..."


# Move the PDF to the specified output directory
if [ "$OUTPUT_DIR" != "." ]; then
  echo "Moving PDF to $OUTPUT_DIR/$PDF_NAME"
  mv main.pdf "../$OUTPUT_DIR/$PDF_NAME" || { echo "Error: Could not move PDF"; exit 1; }
else
  echo "Moving PDF to $PDF_NAME"
  mv main.pdf "$PDF_NAME" || { echo "Error: Could not move PDF"; exit 1; }
fi

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
latexmk -C

echo "Build completed successfully!" 