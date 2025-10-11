#!/bin/bash
# DVC Initialization Script
# This script sets up DVC for data version control

echo "=================================================="
echo "INITIALIZING DVC FOR DATA VERSION CONTROL"
echo "=================================================="

# Check if DVC is installed
if ! command -v dvc &> /dev/null; then
    echo " ERROR: DVC is not installed"
    echo "Install with: pip install dvc"
    exit 1
fi

# Check if git repository exists
if [ ! -d .git ]; then
    echo " ERROR: Not a git repository"
    echo "Initialize git first: git init"
    exit 1
fi

# Initialize DVC
echo ""
echo "Step 1: Initializing DVC..."
dvc init

# Check if initialization was successful
if [ $? -eq 0 ]; then
    echo "✓ DVC initialized successfully"
else
    echo " DVC initialization failed"
    exit 1
fi

echo ""
echo "Step 2: Configuring DVC..."
# Set autostage to true (automatically stage DVC files)
dvc config core.autostage true

echo "✓ DVC configuration complete"

echo ""
echo "Step 3: Adding DVC files to git..."
git add .dvc/.gitignore
git add .dvc/config
git add .dvcignore

echo ""
echo "=================================================="
echo "✓ DVC INITIALIZATION COMPLETE"
echo "=================================================="
echo ""
echo "Next steps:"
echo "1. Add data files: dvc add data/raw/your_file.csv"
echo "2. Commit to git: git commit -m 'Initialize DVC'"
echo "3. Configure remote: dvc remote add -d storage <path>"
echo "4. Push data: dvc push"
