#!/bin/bash
set -e

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Default output directory is the current directory
OUTPUT_DIR="Lectures"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --output)
      OUTPUT_DIR="$2"
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
cd "$SCRIPT_DIR/LaTeX" || { echo "Error: Could not find template directory"; exit 1; }

# Build the PDF
echo "Building PDF..."
# latexmk -f -pdf *.tex || echo "Warning: PDF build had issues but continuing..."
latexmk -pdf -shell-escape -interaction=nonstopmode -file-line-error -bibtex -use-make *.tex || echo "Warning: PDF build had issues but continuing..."


# Move the PDF to the specified output directory
if [ "$OUTPUT_DIR" != "." ]; then
  echo "Moving PDFs to $OUTPUT_DIR/"
  mv *.pdf "../$OUTPUT_DIR/" || { echo "Error: Could not move PDF"; exit 1; }
fi

# Clean up auxiliary files
echo "Cleaning up auxiliary files..."
latexmk -C
rm -r *.nav *.snm *.out *.toc *.aux *.log *.fdb_latexmk *.fls *.vrb *.bcf *.run.xml *.synctex.gz || { echo "Error: Could not clean auxiliary files"; exit 1; }

echo "Build completed successfully!" 