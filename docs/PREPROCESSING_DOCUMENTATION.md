
# Data Preprocessing Documentation

## Date: October 2025
## Team: Team 16

## Preprocessing Pipeline Summary

### 1. Data Cleaning
- **Original dataset**: 666 records, 12 features
- **Duplicates removed**: 44 rows
- **Final clean dataset**: 622 records
- **Missing values**: 0 (100% complete)

### 2. Target Variable Transformation
- **Original classes**: Average, Good, Vg, Excellent (4 classes)
- **Binary transformation**:
  - Class 0 (Lower Performance): Good + Average = 346 samples (55.63%)
  - Class 1 (High Performance): Excellent + Vg = 276 samples (44.37%)

### 3. Feature Engineering
- **Study time grouping**: FOUR, FIVE, SEVEN → FOUR_PLUS (13 samples)
- **Ordinal encoding applied to**:
  - Class_X_Percentage: Average=1, Good=2, Vg=3, Excellent=4
  - Class_XII_Percentage: Average=1, Good=2, Vg=3, Excellent=4
  - Study_Time: ONE=1, TWO=2, THREE=3, FOUR_PLUS=4

### 4. Categorical Encoding
- **One-hot encoding applied to**:
  - Gender (2 categories → 1 feature)
  - Caste (4 categories → 3 features)
  - coaching (3 categories → 2 features)
  - Class_ten_education (3 categories → 2 features)
  - twelve_education (3 categories → 2 features)
  - medium (3 categories → 2 features)
  - Father_occupation (8 categories → 7 features)
  - Mother_occupation (9 categories → 8 features)
- **Total features after encoding**: 30

### 5. Feature Scaling
- **StandardScaler applied to**: 3 ordinal features
- **Scaling parameters**:
  - Class_X_Grade_Encoded: Mean=3.648, Std=0.694
  - Class_XII_Grade_Encoded: Mean=3.424, Std=0.773
  - Study_Time_Encoded: Mean=1.881, Std=0.710
- **Binary features**: Remain as 0/1 (no scaling needed)

### 6. Train-Test Split
- **Split ratio**: 80/20
- **Stratification**: Yes (maintains class balance)
- **Training set**: 497 samples (79.9%)
  - Class 0: 276 samples
  - Class 1: 221 samples
- **Test set**: 125 samples (20.1%)
  - Class 0: 70 samples
  - Class 1: 55 samples
- **Random state**: 42 (for reproducibility)

## Dataset Versions

### Version 1: Original
- **File**: student_entry_performance_original.csv
- **Size**: 666 rows × 12 columns
- **Status**: Raw data from UCI repository

### Version 2: Cleaned
- **File**: student_performance_cleaned.csv
- **Size**: 622 rows × 13 columns (added Performance_Binary)
- **Changes**: Removed duplicates, created binary target

### Version 3: Encoded
- **File**: student_performance_encoded.csv
- **Size**: 622 rows × 30+ columns
- **Changes**: All categorical variables encoded, features scaled

### Version 4: Train Split
- **File**: student_performance_train.csv
- **Size**: 497 rows × 31 columns
- **Purpose**: Model training

### Version 5: Test Split
- **File**: student_performance_test.csv
- **Size**: 125 rows × 31 columns
- **Purpose**: Model evaluation

## Metrics and Decisions

### Data Quality Metrics
- **Completeness**: 100% (no missing values)
- **Consistency**: All categorical values verified
- **Uniqueness**: 93.4% after removing duplicates

### Feature Selection Rationale
- **Kept all features**: Domain knowledge suggests all are potentially relevant
- **No dimensionality reduction**: Only 30 features, small enough for most algorithms
- **Ordinal vs nominal**: Careful distinction based on natural ordering

### Class Imbalance Strategy
- **Initial imbalance**: 55.6% vs 44.4% (relatively balanced)
- **Strategy**: Monitor during modeling; consider SMOTE or class weights if needed
- **Threshold**: Will use class weights if performance disparity >10%

## Next Steps
1. Model selection and training
2. Hyperparameter tuning
3. Model evaluation with fairness metrics
4. DVC pipeline for experiment tracking
