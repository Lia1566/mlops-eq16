#!/bin/bash
# DVC Data Tracking Script
# Tracks all data files with DVC

echo "=================================================="
echo "ADDING DATA FILES TO DVC TRACKING"
echo "=================================================="

# Define data files
RAW_DATA="data/raw/student_entry_performance_original.csv"
PROCESSED_DATA=(
    "data/processed/student_performance_cleaned.csv"
    "data/processed/student_performance_encoded.csv"
    "data/processed/student_performance_train.csv"
    "data/processed/student_performance_test.csv"
    "data/processed/student_performance_preprocessed.csv"
)

# Track raw data
echo ""
echo "Tracking raw data..."
if [ -f "$RAW_DATA" ]; then
    dvc add "$RAW_DATA"
    echo "✓ Added $RAW_DATA to DVC"
else
    echo "⚠ Warning: $RAW_DATA not found"
fi

# Track processed data
echo ""
echo "Tracking processed data..."
for file in "${PROCESSED_DATA[@]}"; do
    if [ -f "$file" ]; then
        dvc add "$file"
        echo "✓ Added $file to DVC"
    else
        echo "⚠ Warning: $file not found"
    fi
done

# Add .dvc files to git
echo ""
echo "Adding .dvc files to git..."
git add data/raw/.gitignore data/raw/*.dvc
git add data/processed/.gitignore data/processed/*.dvc

echo ""
echo "=================================================="
echo "✓ DATA TRACKING COMPLETE"
echo "=================================================="
echo ""
echo "Commit changes with:"
echo "  git commit -m 'Track data files with DVC'"
