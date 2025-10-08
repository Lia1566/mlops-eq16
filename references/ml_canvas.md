# ML Canvas - Student Academic Performance Prediction

## 1. VALUE PREPOSITION

### Problem Statement
Educational institutions need to identify students at risk of poor performance early to provide timely intervention and support. Currently, performance evaluation happens retroactively, making it diffcult to implement preventative measures. 

### Solution
A machine learning system that predicts student academic performance based on demographic, educational, and socioeconomic factors, enabling proactive interventations and personalized support strategies. 

### Impact and Benefits
- **For Students**: Early identification of challenges, personalized support, improved outcomes.
- **For Educators**: Data-driven insights for targeted interventions, resource allocation optimization.
- **For Institutions**: Improved retention rates, better academic outcomes, enhanced reputation.
- **For Parents**: Early awareness of potential issues, opportunity for timely support.

### Success Metrics
- Prediction accuracy: >85%
- Early identification rate: Detect at risk students before academic struggles intensify
- Intervention effectiveness: Track improvement in predicted at risk students
- Model fairness: Ensure equitable predictions across demographic groups

  ---
## 2. DECISIONS

### What Decisions Will Be Made?
1. **Student Support Allocation**: Which students need additional academic support?
2. **Intervention Type**: What kind of support (tutoring, counseling, coaching) is most appropriate?
3. **Resource Planning**: How to allocate educational resources effectively?
4. **Early Warning System**: When to alert educators about potential performance issues?
 
### How Will Predictions Be Used?
- **Real time Monitoring**: Continuous assessment of student performance trajectory
- **Interventation Triggers**: Automated alerts when prediction indicates risk
- **Personalized Recommendations**: Tailored support strategies based on contributing factors
- **Policy Planning**: Inform institutional policies on student support programs

### Decision Makers
- Academic advisors and counselors
- Teachers and instructors
- School administrators
- Parents and guardians (with appropriate consent)
 
---

## 3. MACHINE LEARNING TASK

### Task Type
**Classificarion Problem** - Multi-class or Binary Classification

### Prediction Target
**Performance** - Student academic performance level
- Categories: [To be determined after EDA - likely Poor/Average/Good or similar)
 
### Input Features (12 Features)
1. **Gender** - Student's gender
2. **Caste** - Social category
3. **Coaching** - Wether student received coaching (Yes/No)
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
- Source: Student Entry Performance Dataset (student_entry_performance_original.csv)
- Records: 666 Students
- Features: 12 attributes
- Format: CSV file

### Data Characteristics
- Structured data: Tabular format with mixed data types
- Categorical variables: Gender, Caste, Coaching, Education types, Medium, Occupations
- Numerical variables: Class X and XII percentages, Time
- Target Variable: Performance (categorical)

### Data Quality Considerations
- Missing values: To be assessed during EDA
- Inconsistent formatting: To be identified and cleaned
- Outliers: Particularly in percentage scores
- Class imbalance: To be evaluated for target variable
- Data privacy: Ensure anonymization of sensitive information

### External Data Sources (Feature Enhancement)
- Attendance records
- Assignment/test scores over time
- Extracurricular participation
- Socioeconomical indicators

---

## 5. COLLECTING DATA 

### Data Collection Strategy
- Current: Static dataset from educational institution records

### Data Pipeline
1. Raw Data Storage: data/raw/ - Original immutable dataset
2. Interim Data: data/interim/ - Cleaned and validated data
3. Processed Data: data/processed/ - Feature-engineered, model-ready data

### Data Versioning
- Tool: DVC (Data Version Control)
- Strategy: Track all data transformations and versions
- Benefits: Reproducibility, experimentation, rollback capability

### Data Updates
- Frequency: Initially static; future real-time or batch updates
- Validation: Automated data quality checks
- Monitoring: Track data drift and distribution changes

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

Raw Data -> Cleaning -> Feature Engineering -> Train/Test Split -> Model Training -> Hyperparameter Tuning -> Model Selection -> Final Evaluation

### Experiment Tracking
- Track model versions, parameters, and performance
- Document training configurations
- Version control with DVC and Git

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

## 9. MAKING PREDICTION

- Mode: Batch predictions only
- **Frequency**
  - Weekly: Sunda 12 AM
  - Monthly: COmprehensive analysis
  - On demand: new enrollments
- Processing time: 12-30 minutes for 666 students
- Resources: Cloud VM (4-8 cores, 16-36GB RAM) or on-premise server
- Output: Performance category + confidence score + contributing factors

---

## 10. MONITORING

- **Metrics tracked**: Accuracy, precision, recall, F1-score, confusion matrix
- **Frequency**:
  - **Weekly**: Performance metrics review
  - **Monthly**: Data drift detection (PSI), detailed analysis
  - **Quarterly**: Comprehensive evaluation, retraining assessment
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
- **Data Engineer**: Data pipeline, cleaning, DVC versioning
- **ML Engineer**: Model development, training, optimization
- **Data Scientist**: EDA, visualization, statistical analysis
- **Software Engineer**: Repository setup, monitoring, documentation
- **Site Reliability Engineer (DevOps): CI/CD, monitoring, infrastructure

---

## Key Constraints
- Small dataset (666 records)
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


