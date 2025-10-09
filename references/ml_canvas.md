# ML Canvas - Student Academic Performance Prediction

## 1. VALUE PREPOSITION

### Problem Statement
Educational institutions need to identify students at risk of poor performance early to provide timely intervention and support. Currently, performance evaluation happens retroactively, making it difficult to implement preventative measures. This project uses entrance examination data to predict student performance, enabling proactive identification of students who may need additional academic support.

### Solution
A machine learning system that predicts student academic performance (4 categories: Average, Good, Very Good, Excellent) based on demographic, educational, and socioeconomic factors from entrance examination records, enabling proactive interventations and personalized support strategies. 

### Impact and Benefits
- **For Students**: Early identification of challenges, personalized support, improved outcomes.
- **For Educators**: Data-driven insights for targeted interventions, efficient resource allocation for tutoring and mentoring programs.
- **For Institutions**: Strategic resource planning, improved student retention, enhanced academic outcomes.
- **For Parents**: Early awareness of potential challenges, opportunity for timely support and engagement.

### Success Metrics (NEEDS TO BE UPDATED BASED ON MODEL'S RESULTS)
- Prediction accuracy: >85%
- Early identification rate: Detect at risk students before academic struggles intensify
- Intervention effectiveness: Track improvement in predicted at risk students
- Model fairness: Ensure equitable predictions across demographic groups

### Realistic Expectations
- Multi-class classification is inherently challenging: 4 classes with overlapping characteristics
- Model performs best for "Average" class: The most critical category for early intervention
- >50% accuracy is meaningful: Provides actionable insights better than random assignment
- Should be used as advisory tool: Not sole decision maker for student interventions

---
## 2. DECISIONS

### What Decisions Will Be Made?
1. **Student Support Allocation**: Prioritize students predicted as "Average" for proactive tutoring and mentoring.
2. **Intervention Type**: Tailored support based on feature analysis (study time, coaching, prior performance).
3. **Resource Planning**: Allocate counseling and academic support resources to high-risk cohorts.
4. **Early Warning System**: Flag students predicted as "Average" or "Good" for monitoring during first semester.
 
### How Will Predictions Be Used?
- **Batch Processing**: Process entire incoming student cohort before semester begins.
- **Risk Categorization**: Assign students to support tiers (High Priority/Moderate/Standard/Advanced).
- **Personalized Recommendations**: Identify contributing factors (low study time, lack of coaching) for targeted interventions.
- **Resource Optimization**: Direct limited tutoring resources to students with highest predicted need.

### Decision Makers
- Academic advisors and counselors (primary users)
- Student support services coordinators
- Department heads (resource allocations)
- First-year review of demographic feature usage
 
---

## 3. MACHINE LEARNING TASK

### Task Type
**Multi-class Classification Problem** - (4 Classes)

### Prediction Target
**Performance** - Student academic performance level based on entrance examination
- Categories (622 students after cleaning):
  - Average: 152 students (24.4%) - Primary focus for interventation
  - Good: 194 students (31.2%) - Largest class
  - Very good (Vg): 178 students (28.6%)
  - Excellent: 98 students (15.8%) - Smallest class, underrepresented
 
### Class Imbalance Impact
- "Excellent" class has fewer samples, leading to poorer predictions for this category.
- Model optimized for identifying "Average" students (most critical for support).
- Future work: Apply SMOTE or class weighting to balance training. 
 
### Input Features (12 Features)
1. **Gender** - Student's gender
2. **Caste** - Social category
3. **Coaching** - What type of coaching a student received  
4. **Time** - Study time or time-related factor
5. **Class_ten_education** - Type of schoolong at Class 10 level
6. **twelve_education** - Type of schooling at Class 12 level
7. **Medium** - Medium of instruction (English/Hindi/other)
8. **Class_X_Percentage** - Percentage scored in Class 10
9. **Class_XII_Percentage** - Percentage scored in Class 12
10. **Father_occupation** - Father's occupation category
11. **Mother_occupation** - Mother's occupation category
12. *(Derived features may be created during preprocessing)*
  
---

## 4. DATA SOURCES

### Primary Dataset
- Source: UCI Machine Learning Repository - Student Performance on an Entrance Examination
- URL: https://archive.ics.uci.edu/dataset/582/student+performance+on+an+entrance+examination
- Records: 666 Students
- After cleaning: 622 students (44 duplicated removed - 6.6% of data)
- Features: 12 attributes
- Format: CSV file
- Data split: 80% train (497 samples) / 20% test (125 samples) with stratification

### Data Characteristics
- Structured data: Tabular format with mixed data types
- Data quality: Excellent - no missing values detected
- Categorical variables: 7 features (Gender, Caste, Coaching, Education types, Medium, Occupations)
- Ordinal Features: 3 features (Class X and XII percentages, Time)
- Target Variable: Performance (categorical)

### Data Quality Assessment 
- Missing values: None found (0 null values)
- Duplicates: 44 duplicates rows identified and removed
- Outliers: Minimal - performance categories are discrete, percentages are categorical
- Class imbalance - "Excellent" class underrepresented (15.8% vs 31.2% for "Good")
- Data privacy - Dataset is publicly available, pre-anonymized

### Data Limitations
- Static dataset: One-time snapshot, cannot collect longitudinal data
- Limited features: Only 12 original features, no temporal information
- No continous scores: Performance is categorical, not continuous percentages
- Demographic bias potential: Caste features may reflect systemic inequalities
- No external data: Cannot augment with attendance, test scores, extracurricular activities

---

## 5. COLLECTING DATA 

### Data Collection Strategy
- Current: Static public dataset from UCI repository
- Access: Direct CSV download, stored in data/raw/
- Reproducibility: Original file tracked with DVC for version control

### Data Pipeline
1. Raw Data Storage: data/raw/ - Original immutable dataset
   - Original, immutable dataset (666 rows)
   - Tracked with DVC: 'dvc add data/raw/student_entry_performance_original.csv'
2. Interim Data: data/interim/ - Cleaned data
   - Duplicated removed (622 rows)
   - Column names standardized
   - Tracked with DVC: 'dvc add data/processed/student_performance_cleaned.csv'
3. Processed Data: data/processed/ - Feature-engineered, model-ready data
   - Features encoded
   - Ready for model training
   - Tracked with DVC: 'dvc add data/processed/student_performance_preprocessed.csv'

### Data Versioning
- Tool: DVC (Data Version Control)
- Repository: Git + DVC for code and data versioning
- Benefits:
  - Full reproducibility of data transformations
  - Ability to roll back to previous dataset versions
  - Experiment tracking with different preprocessing approaches
- DVC Files created:
  - 

### Data Updates
- Frequency: Not applicable for static UCI dataset
- Future scenario (if deployed): Annual retraining with new cohort data
- Validation: Automated data quality checks implemented in preprocessing pipeline
- Monitoring: Would track data drift using Population Stability Index (PSI) if new data available
- Limitations: Cannot implement real-time updates with public research dataset

---

## 6. FEATURES

### Feature Engineering Strategy

### Categorical Features
- **Encoding Methods:**
  - One-Hot Encoding for nominal categories (Gender, Medium, Education Type)
  - Label Encoding or Target Encoding for ordinal features if applicable
  - Frequency Encoding for high-cardinality features (Occupations)

### Numerical Features
- **Scaling**: StandardScaler or MinMaxScaler for percentage scores
- **Derived Features**:
  - Academic improvement: (Class_XII_Percentage - Class_X_Percentage)
  - Average academic score: (Class_X_Percentage + Class_XII_Percentage) / 2
  - Performance consistency indicator
 
### Feature Selection
- **Methods**:
  - Correlation analysis
  - Feature importance from tree-based models
  - Recursive Feature Elimination (RFE)
  - Chi-square test for categorical features
 
### Data Preprocessing Steps
1. Handle misisng values (imputational or removal)
2. Remove duplicates
3. Detect and handle outliers
4. Encode categorical variables
5. Scale numerical features
6. Balance classes if needed (SMOTE, class weights)
7. Split data (train/validation/test)

---

## 7. BUILDING MODELS

### Model Selection Strategy

#### Baseline Models
1. **Logistic Regression** - Simple, interpretable baseline
2. **Decision Tree** - Non-linear relationships, easy interpretation

#### Advanced Models
3. **Random Forest** - Robust, handles non-linearity, feature importance
4. **Gradient Boosting** - (XGBoost/LightGBM)** - High performance, handles complex patterns
5. **Support Vector Machine (SVM)** - Good for smaller datasets
6. **Neural Network** (if warrented) - Complex pattern recognition

#### Model Training Approach
- Cross-validation: 5-fold or 10-fold stratified CV
- Hyperparameter Tuning - GridSearch or RandomizedSearchCV
- Ensemble Methods - Voting classifier, stacking

### Training Pipeline

Raw Data (666 rows) -> Cleaning (622 rows) -> Feature Engineering -> Train/Test Split (80/20 stratified) -> Model Training -> Hyperparameter Tuning -> Model Selection -> Final Evaluation

### Training Performance
- Training time per model:
- Grid search time:
- Total training time:
- Hardware: Standard laptop (sufficient for this dataset size)

### Experiment Tracking
- Code versioning: Git repository with commit history
- Data versioning: DVC for all dataset versions
- Model versioning: DVC for trained model files
- Documentation: Google colab with inline markdown implementations
- Results tracking: 

---

## 8. OFFLINE EVALUATION

- **Metrics**
  - Accuracy (target: >85%)
  - Precision, Recall, F1-Score
  - Confusion Matrix
  - ROC-AUC
- **Validation**: Cross-validation, holdout test set
- **Fairness**: Evaluate performance across demographic groups (gender, caste)

---

## 9. MAKING PREDICTIONS

### Deployment Mode
Batch processing only (no real time system for this project)

### Prediction Pipeline
1. Load preprocessed test data
2. Load trained model
3. Load scaler if needed
4. Generate predictions
5. Output: Class label + confidence scores

### Realistic Deployment Scenario (Future Work)

#### Batch Prediction Workflow
- **Frequency**: Before semester start (e.g., August for Fall enrollment)
- **Input**: CSV file with new student cohort data (600-700 students)
- **Processing Time**: < 5 minutes for full cohort (based on model inference speed)
- **Output Format**: CSV with columns:
  - Student_ID
  - Predicted_Performance (Average/Good/Vg/Excellent)
  - Confidence_Score
  - Risk_Category (High/Medium/Low priority for intervention)
  - Top_Contributing_Features

#### Production Requirements (If Deployed)
- **Computational Resources**: 
  - CPU: 2-4 cores
  - RAM: 4-8 GB
  - Storage: < 100 MB (model + scaler files)
  - Cloud option: AWS EC2 t3.small ($0.02/hour) or equivalent
- **Latency**: 
  - Batch: 5-10 minutes for 1000 students
  - Single prediction: < 50ms per student
- **Scalability**: Current model can handle 10,000+ students per batch easily

---

## 10. MONITORING

- **Metrics to track**: Accuracy, precision, recall, F1-score, confusion matrix
- **Methods**: 
  - Automated dashboard
  - Compare predictions vs actual outcomes (end of semester)
  - Data drift detection (PSI threshold: 0.25)
  - A/B testing for new model versions
- **Retraining triggers**: 
  - Accuracy drops below 80%
  - Data drift detected
  - Quarterly scheduled updates
 
---

## Team Roles
- **Data Engineer**: Data pipeline development, cleaning scripts, DVC implementation
- **ML Engineer**: Model development, training, optimization, selection
- **Data Scientist**: EDA, visualization, statistical analysis, feature importance interpretation
- **Software Engineer**: Git repository setup, code organization, documentation
- **Site Reliability Engineer (DevOps): CI/CD pipeline, model deployment, infrastructure

---

## Key Constraints
- Small dataset (666 records, 622 after cleaning)
- Static snapshot (no temporal data)
- Limited to 12 features
- Must ensure fairness across demographic groups

---

## Ethical Considerations
- Ensure no discrimination based on gender, caste, or socioeconomic status
- Predictions support human decisions, not replace them
- Maintain data privacy and anonymization
- Use as early warning system, not punitive measure

---

**Date**: October 2025  
**Version**: 1.0  
**Status**: Requirements Analysis Phase Complete


